Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808F7C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1578910FCE0;
	Wed, 31 Jan 2024 20:31:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41D510FCE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaeSLgcBPHQOhV2u2U6HlmOq+uOP0KjsP09btLBap+zjRg528yZHKT1hTkUg47Gyy4HT2+h3dUXA/gcwmjqo+l99bUXvIUGf/SgFd2gHUlaiwxBs6vweiwwbQ6U1ZBUnVnmwI1CNPCJ5GVR9kQzUkVsPib6dBfeUdN5a5gQ5QkqDr/2viCOhTH4GEU5X7CBB74XHi+zcQK1Ba4pynkBc56QBy8iGjPBbyXh3QrqoBiS/l+B4VHmgCHS7i3pe7Ym+xdlOMYaDuU8CrU2ptN2GpMzMkduoHWjYFhzFqnQL7i2rC/l2kghEr/T/hNDTJSMNAlxCjuKP5MZbZFn6O46pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLSE+6zLFzCJCIb67QreMweBYimqAoiJ/8ChxTk8X2c=;
 b=CP3fXV2rLkbBp2Mgti4tNUxI6o8tgu1ZFyOLzTwT87+i4wK2tropM+u0cKuj3cU5KsEuCQMOm0STyl4GuZyFbHhn+1CP3deI0pKglwaIWbTe6A8fvT4e1ZfvlolEnl96BEon29fEuADreSUG0A0pFin5KSqWv+UjG1QcIf9Rkg+S4Jn5CAtx3UvZvD4lpOeOK2A2yvKHYneXfsmeFaItnKlK6Kk0Uq4K6g2itg4Dl+bdhHF2wI8cTD7h9flApJC0MinjPx0++ZfDtA0AEHSamO5JT4YDebtErmqoG51DKl4Us9R3VDnuptLsg5tb7LkfLk/m3FKZ7O7JiLQYt44lbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLSE+6zLFzCJCIb67QreMweBYimqAoiJ/8ChxTk8X2c=;
 b=0xCXOFi0p5bhNgAHafTSd6dLbA9uxvk+UNZrGnn+iVwb/IljqlZ12dwJZ2AcGW8rdC+JjYCrW2bi7BF7B/5BuRD4ViHSgMTkpc0HpvS7rQm8ib6n0X3q6gbdMbiWAJKbvmTsTfEfiLDv50/Gm8skOh+Y3nehxw++pe4SVX6EP6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:31:02 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 20:31:01 +0000
Message-ID: <c0621e89-8f69-7b18-92fb-37c91c678760@amd.com>
Date: Wed, 31 Jan 2024 14:30:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] amdkfd: fix the cwsr trap handler for gfx11
To: Laurent Morichetti <laurent.morichetti@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240131185012.1265172-1-laurent.morichetti@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20240131185012.1265172-1-laurent.morichetti@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:5:334::28) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: d1544b4c-b02c-40a1-5865-08dc229b8a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAOrhLAmlp1gp1Jj4dMosaJby0VSTOr6Bu61euS8tjsdO9x2AN8X/tz7RyY97akV1GO/MrYagM0M1Hy5hjHLAjj8biNULcZRNCFIXxnYI2UdV9vtbdCqMmn0a632Cci6Nhmhx6WZbl20PkOcJ7o7fHlk/TyTJVo/qttLnEcQYVhTlkLJm14ChKfJJzfns+hkDJRk9npuBrIIN6UrHVHcBHP5cYGKc2uXpkxIyrqq0KK0i8OBcXSgOyiUJ9ZMNpMesVjKEFqx1Bij1lS2peHVs0HeT6wh0ylF2Av7enPCtOFq6KlsgbZreePXWnAd5PgRkXuL3SFzM/uXx3hw6KmvL5sbHAo6kT0yYl0S9dcYz7X56Gt0er2OAV935kf9cWjH3mpv628chf/b8sEALEJ7bP0l448eMUclfUBzMZxCc4ra2sZAM1cZevqRetYce3UENeWM+/ftdP3KcHHoyVINCaYTcTzzIOuEGl7CkXz+lSFmnxUXqT1J9FvxjZpjHHSz9b9mB18Qtd0ytWgdVxTWvF7WEjWog0rJ3gNmF3g3CRdswv2OqkLiPdFmtRWCdJavxPVMnmCg1LLwffXziQQoqmCJ87a3xrxPxcL5kLfiBIXyei7BweAzqYZOrQ4xVbeMoWQ5jp4vvvr2+LNVlTDllw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(41300700001)(2616005)(31686004)(316002)(478600001)(6486002)(6512007)(53546011)(38100700002)(6506007)(5660300002)(36756003)(31696002)(86362001)(4744005)(66476007)(66556008)(66946007)(44832011)(2906002)(8676002)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdWMllWNm8rY1NpUEgzUDd6TGFOWTBLM2dkWGRyOVV5c2NjMDB3dWxNOGlw?=
 =?utf-8?B?ZkdGOU9VbHFLa01FSEhRNTFYUWFuamozeTFDUVRreUFHZUc5UEgxV3RWRTlo?=
 =?utf-8?B?cjdwWTFyencwalFJSHlyZ1k2N3FjOWN3Q2FqYzVvSkltUGQxYzQyVGFFOHl0?=
 =?utf-8?B?eFpCeVZETUR0SkRPTlBwMXMvclBNMmREcGwvRDRxY2lKMGkxV21KeEJVK3BG?=
 =?utf-8?B?STFXc0hOZzJOV3J1Nk1hbFd4aU12TjlINjNTOExtU0p5eEdaWFlVRitHRldh?=
 =?utf-8?B?MnYrVlRYNFR2MkJBeXQvV012Sy9CTGVzTlpuNjlyWlV4Q2dhak5VR1cwbjR2?=
 =?utf-8?B?RFFIa0J4bUVxREFMYzEvNGZ2K1dpNW1oc2JjM3FXQ0tiVlNsQm52MkNrVklU?=
 =?utf-8?B?MEMyRmlOSVFqYy9ndnJKNnNZVFNaam81TzdlMDRXR093b1VnamgrT1JSZmww?=
 =?utf-8?B?eWpLcnBlazJaaGZTM0s4QkhjemlNTXdZWlJQbWlpcXg2RERoZUc4SXJTUnNB?=
 =?utf-8?B?NkJwaDVpWStsVFQ4WU1zZDNPdGxpcmRyMjRwakxBK0ptSG9vNzhmT3ROc2Y2?=
 =?utf-8?B?TUlCWHAxWnNjZXAwUUtKVUJKQjFKSlphS0I1ajFQRGtNSmd2TnRUSnlqV0I2?=
 =?utf-8?B?akYwaytqZVk1Y2dndEZlNm9qaWpRSThjUFo5emFQaGJJRGJreUlNNFp2RG0x?=
 =?utf-8?B?YlFSVVBaMDZ2MWVDR1ZnY0NUeDNxVmp0b2VUWTJIbnJnYzFsK0F6Nkl3dk1u?=
 =?utf-8?B?ZWplU0l4SHNzSnozRUx5b0NycHVDV2J2Q1JmSkl3SEoyNGVzZkFyV292Tkw1?=
 =?utf-8?B?Q3NYMmhOeFFPMjJRREw1NHF3aE1BdWhBdHBrY3pxRWYrUHB4RlovUjdxNGVS?=
 =?utf-8?B?UWpkbkJ0S1lrWnNuQWZLcXppY2taWEhGS3lwZFlUZ2paSks1Rjd4Z1BydlYw?=
 =?utf-8?B?VXRsR2NFdklud0poMlBtTm9ZSHdJd2d2WjVteHI5TEIyNHZ5dzVZWEtWRkhS?=
 =?utf-8?B?aU5NajlMaDBXRndtQzk3UHJuSnpWdlpHbWhEK29URmxDOWJodm5GQjNLcGVX?=
 =?utf-8?B?MXBVYVpSOGVmUjdtTmp4eUI0VmU5R2NWVzBmdzZRSlY0bHF5SmVkTExDbndG?=
 =?utf-8?B?MDd3SGxEWGhWcERObW5MYjFIcVJUdU5Sbms4Q3RISSt1MGlwOTVpSkdua1lv?=
 =?utf-8?B?WWlzdHU5bUlONnNzVDI5RUN4S3BTSnRsZ0wwc3l0cGNSSmFhTGhQcFlxQWJu?=
 =?utf-8?B?ZGMxZi9QRnNGVUU1ZkVPWDlubkp4TXVPOEI3WEVSTDFJT25TcmdDWXJML1NC?=
 =?utf-8?B?UzJyN21hVy9RWS9sQlZSSTY2Y21LZXgzYmE1VGxPUEtqZDB1TDhTRU5iem5h?=
 =?utf-8?B?c3RQb3htUVg5clIwdW5hK0ZSdkdmaHd6WkJmblFFR3VqUjAvRmJtNHkzdGQ1?=
 =?utf-8?B?dEh6ZnVVbXV5Y0MxcTdoWTlxckRNM3R2YWdUQnEybEY5bFE4cGNXaDlHWDV0?=
 =?utf-8?B?ZjJQMS9LVTIvMUwvUkNMZWpEMCtXVUFwYStSQWZ4OFFmMWJON0J1WHRaV0kz?=
 =?utf-8?B?eEwwRzZiWmtNV0tmenMrRG5lakhuQnc0RlkwRFFWREE5N1NnNkdzTitOUlc4?=
 =?utf-8?B?ay9kNDlLSXBKc0h1eEYrajkxU05pMHZKM3R3NzJHYmRnVHZuRW5LbTlablNR?=
 =?utf-8?B?UTl4aVN1T015RnRoak5YNFZ6SEdrb1pCNDhkejZWdzdhWEt4QkVtdjVnL0pV?=
 =?utf-8?B?TDI5NWRvTktCNlVKNTJ0SzQwckZCQVY5cmJKNG1ERTlQekhTbTlDSDBWbzhB?=
 =?utf-8?B?VTYrN2NjR29JeDR1QUlWK25jNFZXUE9YdmZadmNBdDVoQzZybU5CK1BXTUVG?=
 =?utf-8?B?TDRWcTRxSzMyaVZuVUZrSGZZajhYK1liNkZHcHNKZTRhbHVrR3ZGcTUvZ055?=
 =?utf-8?B?MG5RS3BmaHhzZzJwblNHKzFsT0VpTXJOQUNsV3ZObklzVUhUN3VUN3Vma2Fm?=
 =?utf-8?B?UVdRNktPVTYwczNZZ0RvUXV2RnNOUjdTbkVxM2sxbWtrb0NWZ3JNVTdxWjRr?=
 =?utf-8?B?TUI4MkU5bTJsbFA0ZjRvY29vNGkvSXR3QTF5Njc4ajlTUUQ1MXIzeWw0SXlY?=
 =?utf-8?Q?J2J+BKO1JglK0xMGzoC6k58a6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1544b4c-b02c-40a1-5865-08dc229b8a63
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:31:01.9345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7idm/PCjhX4Qcx2XTyH3Q37vYc5aa3tnKsnhAoCw9tvDTo1b8h6IyW/RdWU16qaAIE2eK75x4B3pOAIalBcPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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
Cc: Lancelot Six <lancelot.six@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/31/2024 12:50, Laurent Morichetti wrote:

> Call the 2nd level trap handler if the cwsr handler is entered with any
> one of wave_state, wave_end, or trap_after_inst exceptions.

^ wave_start

A more descriptive title would be helpful. Perhaps something like "Pass debug exceptions to second-level trap handler".

Besides that:

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
