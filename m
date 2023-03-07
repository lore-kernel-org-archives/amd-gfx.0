Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EFEC6FA99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 23:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E519910E158;
	Tue,  7 Mar 2023 23:21:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B70510E158
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 23:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEMGNSnw3T+K7e47PwF5e3W48MGcsLBhmPgjCUQ5S50DOccSSpQTazs903qaArEdaTr2sGiYvpD8274+P4cUiIGdscNyhYiL7gNJ11zFkC4cj8VHVW23ldSbzr4jhMELOfIZd1MjudNS5rJ8uV5s060D2Y+0z8+z1+0S91z4ABVME1fWW+RCNw9ARIu1KqHTprOQp9Dz/FiljrsJkviH4so3qtI1Xafie/1ljPBhwerEDiW7NmXYEMwznzWcgeKCs1FX1CtdxyuGLwKUw9Ol8/tajAWMDSOhD72jW52rQLBSY45tfi5aP9m4y1S85gJl5O358oOieP9VpNNMSuV01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mDOVDBofkLsvrEnV9e1E46xPvE0H+ojWDJw72ot8ao=;
 b=CAcUgDYROqbeuSS1UieIChfFR7BBodtes7X4p6vduntYL8xHltLqQ0iTDF4zN8O3NTQw5USUQzSSf9GUutDFL+VvZr5cFKuCSOW1BmEWz1fyiCOaU/6qwwGeayLpjaevpyM1uij/LxrJFOdzMqj8lJ0QmSXG5kqbaFOsrFoj6sSxMApM0wihwTsVC+iD9xbZoAUs2e+WQ7YTiDiBpH/0AFdKZ72O9VV/E8eSpc5oTfvltAEKEXZh2wO7Wo5rF7tFKuh9B+GgsMi5WOMli9h+ELdQ89/2hdqc7yaPjWnycqXobWl+11DrgTsULMQwKZ1PZop2Xv4fgFQ4uPdQFBhwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mDOVDBofkLsvrEnV9e1E46xPvE0H+ojWDJw72ot8ao=;
 b=tDMFtsmQBk542pFWikHANBItOnu8AxpRzI0wjbIZMlj119CDNMXU9maT++ax22bmyq2/ugnMf+62u0l2ctN62eBMQVcvDdXng5KAGi6gO5z37l3HuSXyqDIVj/wrK5FjH5i2zUk1U3MAhERsVJEPK6C4g4Rr/utWquJr3lkS54Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Tue, 7 Mar 2023 23:21:37 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 23:21:37 +0000
Message-ID: <f7e279a3-f26b-cdb5-ed5b-8aeb2344ac98@amd.com>
Date: Tue, 7 Mar 2023 18:21:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230307070231.3807549-1-YuBiao.Wang@amd.com>
 <a38e637d-2cd8-caa0-e27f-4c9b8dc101d0@amd.com>
 <c01e8d00-0565-0015-0e69-ca22260c70c9@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
In-Reply-To: <c01e8d00-0565-0015-0e69-ca22260c70c9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1P288CA0011.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5ac2ee-f30c-4e73-d902-08db1f62b2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPurSL5mAu68+vAeazw0Dl6zlb8V0X3D8Gjp0FPns244WtmNNUUXFx9IU/mGIwEY3X0XM6T0KX1fTC43bINVP2nD3mo8bRoRaRVFojDfenueHlNa4zT6DxqZYRyaB29Nj4HPvVhpArI/8gWB65doFeMOc3x1jpNePYPSgyxeLvHKLOKxvzfBn4sZ+MKFFLaDvN0i9pdpMGZvX2SdO6QdpovF3egYo4Njmru3TMxhhPjAC7h3kBJdiIe+5dtMkVd08DUCmKobKRRQ4Psotb3UBwUq/UDt76uzUcjnx6Y172SufxcqTF0hZSjyz0ftz5cEdmJbkcOY//41eNj9VBkyjVQGHIHhDrIse8yZ88DthSIajLR22K8QZdON9vCwZOMTswoaMvkrEHHbLMrKXe2lQU4Qtn6swxNJvdPChXOeePGCFI96nsJemeqDW1Up+eZfSP/Zc6F1fZT0QIjLEaCX7RLofSH9oq8pB0fsYuh6q/qsEk25+vXGTUKtAOz1rWbJE51/nLDdKCFlPgAsEcizRH3+LVv7xfjS7vLPhSUUccZs4LFFJrpu0tD20qjlGeEVPQHvrFXuzo7Ou60dMJjn6D7XjKK6A2Kl2Wlc0bulY4C6yt5089meXWfotPYSxiFZ4lPEhHLM8GAWDSUVfuEtc8NJJkYbalZOwW2krHX3wijZiXH2gjTytq3qBvmMtWUEmHI5R9sI3u3bBrkAOII9iJ0aSpdD1xpwoNQxfSRZZqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199018)(36756003)(66476007)(66556008)(41300700001)(4326008)(8676002)(66946007)(38100700002)(31686004)(316002)(110136005)(54906003)(8936002)(5660300002)(478600001)(44832011)(4744005)(2906002)(6486002)(26005)(6506007)(6666004)(55236004)(6512007)(53546011)(186003)(31696002)(86362001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJ3RzMyOXhWSXpPdnVtcS9lN0laUkVSM2dad1ZtZU0zdURGa1RNRElLaW1i?=
 =?utf-8?B?YzlRNWJQYnlNOU94OVBZWUYvc2ZxVTRyeDM3VHByWk1RMml3RUoxNHdPbjc0?=
 =?utf-8?B?M0I1QUpUREgvUG1ZWHhHU1BaRWk0VUVpTEVmNk8rbmRvTEowWUdGTHR5YjhW?=
 =?utf-8?B?eUFRZGFTN0w5UzdBdDJjdTBIa3ZOYVJzNDhJeEZlZkZaYnI0NWFhcEFRbmRw?=
 =?utf-8?B?ZjVTbmhveDJuNEhBYTdRMGgzeHBJNmVYdUFjNTNING1wQitqWVV1aDcrZ2Vn?=
 =?utf-8?B?L0hWTCtaMC9ueFVjVHdtbHZRNEd0bDFyVGxxcjNmSnU5S085WVNFbzZ5Tk9U?=
 =?utf-8?B?aHpZSXJuVkRBTTM1OFlac3pabDRPdktrejZMV2FiZDF1dFF4U1l1Vy9RcEMr?=
 =?utf-8?B?RWk5ZG5ncjUyYjJVeWVZT1ByTUc0UjZBaHV1UmVkMERNcG9sNTM2VWRwQTIw?=
 =?utf-8?B?K0FGT2dZTEVVaE1TNVEwc3pidXZSTnQwQjRsdDAvcFJMS3V5NVlOdDB6dU80?=
 =?utf-8?B?Wmd0c09xUzk3bXcwT0UxZ2NrMTRCK3NSU2V5M25qUGIwaU84WGJNb1JueVNB?=
 =?utf-8?B?MXVaMkl6KzJnVzB5emVMU2JEMzNHL2hOZGl5K2h5UlU3cE5mZ3htM3kxQnh2?=
 =?utf-8?B?WndaZTJsVGpqQklTU1lXaUxGMkxNemU0eVBZY1JtZ0k2ajJoOE5iaTlyNWc0?=
 =?utf-8?B?QUVvL1VQeVVzL1d0ZTlVbEkvTmtyUWtVUFRmbnJlMGl1ZUpVYnJad1FyR0ZO?=
 =?utf-8?B?THhGZC94OWlLRW5Sa0hFN0dXcGRIcHArdHlYWU92R2grMUZGdVlFc3VMU05t?=
 =?utf-8?B?eEo5VHpvcEMrMS9ta1I5WncvVWlVbUQ3YnUxcDAwMkZUdGVhWlYzSDdBd2x2?=
 =?utf-8?B?SlB0S2IxY0Y1R3loNHdYY2NpK1BoWTlYNVRxQTZmOUplV3dmZkdRV1dvaHNN?=
 =?utf-8?B?RTlsT1hjaGV5L0xxdmxmN0xObTVoeXpLWlJPNHZwYk4yMFVycDJVMDhkN2hC?=
 =?utf-8?B?b056UVpDak04bzE1ZEsyU1g5RE9LM2xuYzhkcDgxZURuZy83YVR6UFF6NjVP?=
 =?utf-8?B?OHlFSk1qeVR6d3FFNnArL0ZpTW9KZk1lWWMrRXQvL0doRXg3cWlidHhKeWdK?=
 =?utf-8?B?TUYzWi9hME4yaEV3T3RwUFFrdDJzdzBGc05qRklqYjY4cmpNNitsejNjbUJx?=
 =?utf-8?B?OHV6MWh3UCtFWXJwRVlBaEhZaVQ5Mi92Qk5paW5WK2RzdVZCdXQxWWNscmFy?=
 =?utf-8?B?OTVMblV1OXA1cVNLMWtQWGNNd3ZsazhnVE1sMTNQdCtqZGtNdC8vUWFYSlpW?=
 =?utf-8?B?NGRaeVZsRlRjeUg1UVE5bWc0WGh4NGRzaWFuZWJlRlMyOWtWZFRuVlhmbCtH?=
 =?utf-8?B?a2J4bHAvYnRIZEJJR005Y1YxSnk1S3BpUkl0SzdISzlucTE5QVdJQTgzcTdh?=
 =?utf-8?B?R3V5M1UzVUNrelpUN1RCQ041TklIVFo1YmVIMnpTVTdYcE5hYnJISHVwdjhB?=
 =?utf-8?B?NWpLQTFiMVF4cGF4MEJpeFZrU2FVbDdWSWpydTVqem9HRWU0d28wTGNxTGth?=
 =?utf-8?B?RW5uWmR5SUFoZnhYcDU1bzN4dGdZYklYTlR1SVE1emlzbUpNWVAwZmo5ZmhW?=
 =?utf-8?B?RlBnNFJGZytCU2JxcmkveGtjQVlhZWcrQXBUQnZqMWZXRDR2Z1ptM0YxQkY2?=
 =?utf-8?B?Uks0L2ZvcmdhNGwzcmhmUmRBM0ExT1VYdkliQWZKUDNXVWJSQ0VUdndTbTB3?=
 =?utf-8?B?NjFIZWpJUCtKM1VtdC9LTzZtU25xaTFxWWc1NEVFenZneW9SQXFCV3BDS3Qv?=
 =?utf-8?B?SkZUWkI5ZUF6am1RY25Wa0tuc2JZQk9BY0p0Z0kyOFhlYmNtL2N6Y3ppRU50?=
 =?utf-8?B?enhBVFR2QWdveGdMNkxOcWt3RndlbFgyWGwzTWhoQ28ybzJvRkpub0FZZWVi?=
 =?utf-8?B?V0wxcGlQVEVad3RWb1RZNVJnR3N0bUowa3h1Q0RLNVpHZDV3V1oyT1ZzK0JQ?=
 =?utf-8?B?aWNvb3gxY3JiM1lYRy9DS1NIMlBKZ0dyeFNwa2x6enRLdmUyVWVDcDdNTTVO?=
 =?utf-8?B?VitkbkFzd1kwWXhnWnA4YTdCMklydEVKTEtERXErMUx4a1lKWDg0ekFCMC9z?=
 =?utf-8?Q?gCXSyLGJEyZbOavAncbsD7Zid?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5ac2ee-f30c-4e73-d902-08db1f62b2a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 23:21:36.9845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5pt9g+xZkvNME7tM6X1TbLKl2l/po4Aat86YJqDtY282/wo6ARLzsjeUekJgsWz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-07 15:36, Luben Tuikov wrote:
> +			job = container_of(old, struct amdgpu_job, hw_fence);
> +			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> +				dma_fence_signal(old);

Thinking about this more, is !job->base.s_fence condition here
enough to mean "non-sched jobs like ib_test"?

I feel that it is a bit overloaded here--could we have this condition
satisfied,yet we can't willy-nilly signal the fence here?
-- 
Regards,
Luben

