Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CF6FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 15:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4A910E67E;
	Thu, 27 Oct 2022 15:30:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CC510E67E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 15:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3o5AJEsm9lFcpuLmQT31Kjo7yenGOvah8AsCtEotO8SHfvGPdtdP1a3oFjJEvObx7GMxZZJwNpLLm4kVolTz6yQ00d+QasP6EaFP3FH+Rusxwb7SzAmzF4ryMgdqmCauRQW1U24R5W7mMUaDlebhHtmK1RZfDnGp4g4uDe40EPNkhxWdzVqj0JN+QSXCbYbx6KyWPmQ2V5Z3H5vDfoIPkVtZOX3SUl8OK+vMzUlp0KFFugbGb7wa/yWEjh0l5zQUEheWjB7yIJfWSu2wIUfns4CcVekjfKu79BIzPaZKkedOkzSHmwth7sZdzHQe7VAw5ZO2T9FYh1aoJlfKvUgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drPMXNdJTrvJwkz1eZVf8yNZhlOGSQAf5KFFjXTJD4U=;
 b=Flj/T4ToWU4EwtPGZZ8fWqe9fc7aSfZ07KRRTVQKHjxTgkZ5Vy8DKMcIk/QxXP6wpOgN0fewbxjcSNbiMPC2YqtRBZ62Iuwm9quIkjBQxAFXp7DxYQzmMKKjURWjRDpig88eIKJ77pVo3km6H9cMdfEHL7/PyBbNZPjXqfJI+KqtEs8m7IEhuUhlTewDe+iXBcXNLLE6f2VmVMMK8dLKI4GxoBqMNUZyLTMQJmZuH2PCa9H82HcqRtS0KNPoX5T0cblwEtWQuI7UvDADEh1PuXbqCx27YmeWyVuX4lUdFSXq7Ym/P5b11l+vwAydKD7oQsZed59VaOfrlQRsi3lHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drPMXNdJTrvJwkz1eZVf8yNZhlOGSQAf5KFFjXTJD4U=;
 b=B0i40LlXSAaPwHzDzjIdoyRriY5d1wqArW5Y/iJJPvGUsbkplIEFs7aM0OyCvZL9FnyEcblrnstWsK4qVkIqWJI6RiSJ3jkLoC6KJWotA11F77QBWfaVGa8hzNAK+/bZ2m+CIK+VNx/7LWkrQVO3HWjR/xnKKGX1fwnRdCSD884=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 15:30:12 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 15:30:12 +0000
Message-ID: <cc9a5e36-87f1-8222-a943-8cf6f1a5957b@amd.com>
Date: Thu, 27 Oct 2022 11:30:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
 <Y1qiHbjdZNNjxFq5@dev-arch.thelio-3990X>
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <Y1qiHbjdZNNjxFq5@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::24) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb8c4e2-5ad6-4869-3e53-08dab83023b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uwwer3HPCZTUjKQU1Qs296EvNDceWud/fd1GOBtnpKmdZlX+AdTnXhmMrLGOl4jGAyvNdpQCt5XzUawp5VeJ7Q7mt3rhAwC/ir+pfBigdYKi74kanawi/QMBqLmWbme4RknqqSo/wxr4z8bSYDm9rIz/tsdeUUi6ZrgtbystLxYYBZMRSr9rQ8UEA5Wd6cKVhPszgNAGVubwPUiNojrir3gMZszs81AjGND9NWzZsWVRksHtN5Q6O3lRdXc0e+nUfdAHNxsWb2pwUF4mXfUnenFV8FrhR74d0AVzH3Nnub89Y5ePB4oe2qNa5R9gOq5GzeoBMpL/POgFxsEeYZgsrepZLsc2DrWT6gxYOBM123qhGf3PmMbe8JKvjJF53CXIuF+NfFUGUFQUrCf3zVPCBOO/Vz9onLJneVrBKUgA3J5TqZYhm0c+N25b1OZicmkDdeF0XXs4R61nH7bhyOF2ZGZLzwlYL55EOX7Psp9QtEeW599wV7Jg8NGuk9dj2pv6qZOyAKkeY1+lzSXnjCUTIV3wm1diLf+rFXd0qn0C6R4PGVlBGvimsZmzhlo7HmShk7Gv3LE+lt7I74jO+pwLrBg50eAQNGUUTrGrzJpP0OtlNyhQd/JdnVp89jbxbWaZ8m87jXBUc9csL5WI48dxRmxf/ZjLkrGPlyBZ7hAiKMbJFwkYtEphJM3R0BcUp6Z/K6jotv+YiFOdVnF/gY+HpWhHPQcp5w5tj/1W7BDOrNiE2/PahPyUiCV7AC0+QTVJXMfMpW2zDAOE0H6csznqoJhceSRCJVQAulpsViijjkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(2906002)(53546011)(186003)(2616005)(6666004)(6512007)(83380400001)(6506007)(41300700001)(31696002)(66946007)(66556008)(478600001)(6486002)(5660300002)(38100700002)(6916009)(54906003)(31686004)(316002)(36756003)(86362001)(66476007)(8676002)(4326008)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JHVU04VGVRWG1yZXd3d2k4aTRnQVYrRmg0WEZ0cWJpcjVvM1IwQ2tWS3Jt?=
 =?utf-8?B?bXpnaFp5Yld4SWlVa2JoaXVtMlRlKzhzbHZidzRtenk0eWZZNXNleXI2YXdw?=
 =?utf-8?B?RytSMlRHU3luelZWaGZQejFDV1NTRTNiNEpVb2MyN2hiZk9xZ0FndmhtQWsr?=
 =?utf-8?B?RlNKdzV6TW9BazVZcGhpS0NSWFI1YlZ3N3NHVDNMTkhidkVvZnd4SWhvYVZY?=
 =?utf-8?B?KzV3em8vOGl0YUtjcGxCRC9ZQmVNMUZJQW5XeFJRYS9VV09TTlVVWmFDZkIy?=
 =?utf-8?B?QTN2SjNkTFJIbEtqcHZTcU9tT0pEcDVRV2hucTBMbWwxL3o2QWxTM0podDk0?=
 =?utf-8?B?TlJGSjJVUU8wb3h1ZE9vY2ZCbVk4QkIrNytoRGFrMitmc1A0ZHVOUTJHTlkz?=
 =?utf-8?B?SmJieS9GZ3dBZXZEM1g0a3lwaFRzNDdJMzZZZVFjZng5RjcreUJmQmFXTWdS?=
 =?utf-8?B?SzhTcU9ZT3lrUlVpOXl3NUsyc09YUmY4eWV2anhBckhOUW44bGQ0MTlJNDk4?=
 =?utf-8?B?L2hWSnl5dTNyZUxmcTk2STVENXh6c0htYTRGOCt4YzlDcFRTWTY5NE1TNk4z?=
 =?utf-8?B?eGtDV2l1bStNd281dTFWUXdXdkwybzZHZmJ3MlpOcGVOR3ZmTWgxemNjNFNW?=
 =?utf-8?B?UmNLOEJYdmptdjFOZXQvVVdTNGZUSG54b0xCUllzSWE4SExRYnROQU9IWE5I?=
 =?utf-8?B?UHJ1R0xJaUg3Tk1nV1N2TkhGK1lVbE1aUXJzanRZS1Jmb0orbUhXYXFOSm11?=
 =?utf-8?B?clVUcG42T25aVVg3b0IxdldBaGVyZ2N3NUc2YXFDbDlBVE9hVVVjWk9KNWQw?=
 =?utf-8?B?eWZVYjlEVG5Mempnc2FBRm92eVAyU1BPTEFwMW9ZeEJ4SXVYSWwvZGJiM3o1?=
 =?utf-8?B?ZVVkVkJSdmF1N0xMVGNCdHgvaFAzemRZNG81WGFMZmpPVXBWN05GVmVrZmZn?=
 =?utf-8?B?RkN1cEdIWDNtTHY5UDlzQjgrNWQzN0NBUnpQMktCYUEzZXQzejFkbzQ5MDZI?=
 =?utf-8?B?M2l2bko1clU4SEllRDhZODJja29XU0N4L1ZnMlgvVHpZT25ibDNqbHZQbU1l?=
 =?utf-8?B?SUc5SGdnN2lkc2p4Q2ZkTVRObDhWUjROS2ViMUcrWnkrcG5ZNURWRUNYVXNk?=
 =?utf-8?B?M293OXFYRmU1YUtiUE9jUGVIY1d0K3BxMTU3b1dUczBsQm5PVEdJcG9ZK2N2?=
 =?utf-8?B?ZnFNY0VuZzJuUWluV3A5cGUrT1VMNUk0OXlGUlVRcUpoWnFqYW1tQkpuM0Qy?=
 =?utf-8?B?dGJ6Zmk0a2pKYlBXek5nZnRnME94aVNTL2FNMGRaTGpJdE9iaUttMzVIVWg5?=
 =?utf-8?B?WEZka0psSk91a2Zrc1NzdU5meXRWMXZLQyttREsrTmVZSkxaUTd0ZWhIenFa?=
 =?utf-8?B?TjhPTi9BUXo1WFN5bUtLWFgzVzdLczY2YkU2TVFZd0ZEemFVMmViQjhQU2Iw?=
 =?utf-8?B?RXd4WndEaGNWWnRTQmdCNUxWdWt3bER3dUdPd1Zuc1JtaElMZWFEVG5tdFB2?=
 =?utf-8?B?VEl2U1VuR0VHenNhRC9QcWV5NzQ3cmhrNE5WMis1WFNkMSt4aDFXUEZOaXBM?=
 =?utf-8?B?SlNHY2l1YjNLMXRkRU1rMnQ5ejA2b3ozeGs4YW41UlA3cHJ0SytlWmFIMzBB?=
 =?utf-8?B?VU4rK3RiQkNZMDl6Nm9haXA0KzRodDE4NEx6Y2Q3RTk3T0pjT1JjK0U0NllJ?=
 =?utf-8?B?M3YxTWtDNlhlWW1KR0p4cWI5VnA0OUVrRHg5azNGQTNaYWdZL1FRSm92NnE3?=
 =?utf-8?B?T2ZFdXBISEJyRWt6TkozQ3diSTFCN0I0Q2NkTjA2Z1g5S2ZxcEY1cm5kRHR3?=
 =?utf-8?B?b2tvd0I5RFRmem1ZazZrbDBSS0NERGc0RXhQblFUcno3aCtDTjlZTVNoa3J1?=
 =?utf-8?B?Z3B3V0dnSkJaUDd4STE4WnZpQWlKR09mbkNwYVZ6c242WTdKR08wU05VQVFY?=
 =?utf-8?B?NXJBdFY2TzhxS3dJVEV0UDhZOVc4bTlCSFlhQytlZGdnS051anRUVGNmUGo3?=
 =?utf-8?B?QzN0R1lyVkRWcm1xSko5OHJIVUkrSEdpTWtWTUFQVU03enFUQlpQVloxRjMr?=
 =?utf-8?B?VnFtRmtoaStWd3pvMFdubW00dXF0RldKaUVYakIzNldWbmRZU0txK3JmN2dO?=
 =?utf-8?B?QVpSYU5xT3VuZVY1WXhMcXBNVlQzYlIyM29Tejd3Y2FrdGg5bU04bDlMNENu?=
 =?utf-8?Q?R7sqn9m1y5yCNXCvbk6rVTQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb8c4e2-5ad6-4869-3e53-08dab83023b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 15:30:12.4577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+6/E7/Bp+kuwsooGMgY1KdT2A2WkpnBozcC5QARgDNobQqQ5oxjZ175J2kszt10VoyfNPwJ3eiXJkesz0L7Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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
Cc: Ao Zhong <hacc1225@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/27/22 11:22, Nathan Chancellor wrote:
> Hi Rodrigo,
> 
> On Thu, Oct 27, 2022 at 10:29:33AM -0400, Rodrigo Siqueira wrote:
>> Nathan/Stephen,
>>
>> Maybe I'm wrong, but I think you have access to some sort of CI that tests
>> multiple builds with different compiles and configs, right? Is it possible
>> to check this patch + amd-staging-drm-next in the CI to help us to
>> anticipate any compilation issue if we merge this change?
> 
> Yup, I have a build framework that I have developed for my
> ClangBuiltLinux work that I was planning on putting this through to see
> if there are any new warnings that show up in this code since it is
> going to be built on a new architecture. I will report back on Ao's v2
> (or v3 if it is available since Arnd had some comments on v2) when that
> is done.
> 
>> Or should we merge it and wait until it gets merged on the mainline? In case
>> of a problem, we can easily revert a small patch like this, right?
> 
> Sure, although if we can catch issues beforehand, that would be nice :)

Hi Nathan,

Thanks a lot for checking this. Let's fix any issue that your CI reports 
before merging this patch.

Thanks
Siqueira

> 
> Cheers,
> Nathan
