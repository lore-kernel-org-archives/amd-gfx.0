Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E073DC4829D
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 01:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12BE910E114;
	Tue, 13 Feb 2024 01:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chOWpHdR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5669C10E114
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 01:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRKQgvgeQfXxmMtK2CcoP7lCjZ+hDtYM8BertwBxeQcb27g4nR5WtX6DVa7pjuHbJTsv+Q0ugy9JcKImIlU6oH4/W8SFG9zFpGmb0Gz40ukclVvM0B5u8LMwJcG6di4KdgY0yEY6xryM7Rqd2RlLda5YXzKfUiTR9GHMvje4j5Jo29AFKGkg0rs6QLzaQ9OK9MlqnjxCCiDi1f7Fg/Ezd8l3bMeY233PLyR4qxUYW8as///8dk9tWBdvob/LdTU55od7O7K1iKguJYYC+EdH/q6vqQ1LhTkB2B6eMY31xnLiu4+ToVMWuPZOS9Wt8YQ6CcYVmKBuqEhFPA5lxCWMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPLlBI6e1GVnItsee19xZy3cV8CVlLnyWo3s3S9jrmg=;
 b=egSQf9esfmmtQ20fmdOw0rQHP3YIC5Z9c1dH5cIxzETMAT+4y39fVRCcWGXZ06zx9ihOWu6kSBa2l1eUboiT7FdSjj/Y7cjTEi6dI+tzQzB+tP8nQ1fIzAHGJyafrMsx+OnUS+KPRlID1hci6N9Epe9dD7XTN8q07wjNiaWu39m0rPvCq45by+Wgvo4O7Xo+Bc+4JllDqlDm02Hyfg3tHFwdw8mVQaZ8H7eZUzTTsTsSj083HXHWEDpTsIrNhiGJrBfeAW3RV2GWg8H99zVXAusNCLGZrGh1RHDK4Ul5PKDjNkSj8nuthJ8RaEjJFfCwL0i7ycumDZMhzndspltArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPLlBI6e1GVnItsee19xZy3cV8CVlLnyWo3s3S9jrmg=;
 b=chOWpHdR9nx/MwR7XNw1Dm006QXfJBg7WJ2p4OuItTphAhWMoadZMzJ3V6I7wLnLned8KuaiC620lw259WJWoewHd0+TikuU4RLpC+VEFQfVqLcHM3NIwZZewPPJgUcMapP2A26rECUVAnzsGIFMB9ZKoS7qcEefuT5Pt/bAN+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Tue, 13 Feb
 2024 01:27:10 +0000
Received: from CH2PR12MB4119.namprd12.prod.outlook.com
 ([fe80::9d8f:d9c4:133b:e56d]) by CH2PR12MB4119.namprd12.prod.outlook.com
 ([fe80::9d8f:d9c4:133b:e56d%4]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 01:27:10 +0000
Message-ID: <12296e1b-7382-454a-8b27-efc2453a8bd1@amd.com>
Date: Tue, 13 Feb 2024 06:57:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add NULL test for 'timing generator'
 in 'dcn21_set_pipe()'
To: Kees Cook <keescook@chromium.org>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240131032820.699251-1-srinivasan.shanmugam@amd.com>
 <20240201095845.1171852-1-srinivasan.shanmugam@amd.com>
 <202402121036.F9F6B82F@keescook>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <202402121036.F9F6B82F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To CH2PR12MB4119.namprd12.prod.outlook.com
 (2603:10b6:610:aa::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4119:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b74213-1de2-45b2-503d-08dc2c32e618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hXS4QkNd4Fd+p7IYeUM30cM6PYdpgXsD4H1yk9dTDZOhxNKfPylEi8QBSi13xq+pAbweMoFloBHX9uoVoR1jr9wqbkgM6sXHYDTKSC70D3SbTX4ojp9i4N8AGyYQz6DbeydTsC/d/vCE/lSjLCtcF32/53Bj9MrSu055WL95dKYMWk85ckZM4corpQWTmEzDjzg7BCopONKQcZihrLHiAJIVTValYCxjCU6xEUph+ce9y+Jb310EH7zLuh4U0jdxznj0dLXr4eur5Z3HoSG+RswgbAN/qu8stwp2QHxuoo8+Qgwq7jQo+bn48gX70+fFxdc+oWS12ywkTJ32bjNqJzBEIsmlos9awiFx5yP9G6jn9yLmwnUdjOVwaV74HHDOt+MG9Zg3otzYvYU2qzgwG26c019uZjkJ5RsMNciW0LTzfm//kWktpIWixWXBKCPcd7SaD4RyC4DxyOmz5C2s0OcMRqg5o4d68hFCFPb2Bi5kvH7qw5J/+gY6o2sqKfPb7QAXWZlgF/YXsZIMv1fp3hBUO5kKsdFHFpwoEaFpmQDygSFxsZpXgj+vt0SYO8Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4119.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6486002)(478600001)(26005)(53546011)(6506007)(2616005)(41300700001)(83380400001)(2906002)(5660300002)(6512007)(66476007)(54906003)(66556008)(66946007)(8936002)(8676002)(316002)(4326008)(6666004)(36756003)(6916009)(38100700002)(31696002)(86362001)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTByd2pEbWRjS2k5SWY0VGlwOHFrZFE0cXR6UGZyeFVCaGhhV2VwNnY1UkVO?=
 =?utf-8?B?Mk8zYXVWaTlUTUo5MFhnczVOZGptcTFORzFTYXpuZmViaXA3YmY1NXhiYVV6?=
 =?utf-8?B?eFc4eXdBSXJ6VWg3V0IzSlJleE1JZjFTaWVJb2JjWHEwUUxkdHZYTjhlSVFI?=
 =?utf-8?B?Z1JvSm4wWjNDc3YyVGpETnUrMXpOK1Z1QmhwWGR0R0lLOE03THpmejNyU0kx?=
 =?utf-8?B?T3NEdFpDUTcxSmUyWS90QWdZQmMya2hNdFQreFhxSUFLRHpta0o1ZHlYU0NE?=
 =?utf-8?B?a1FDaURxNnExcmd6SFVMVDg2Qm5SVkNjZTR1em8zK3JiNW1YZHZSeWg3Tkk3?=
 =?utf-8?B?WjFWMlhQRkxNMkRpY3JkQmJWNkQ1WUtlcU5SbDA3Tmh4SWZBRHhSdG1QNmFG?=
 =?utf-8?B?YmNGUDNVaENiMUN2NCtpdzRMYnlsN1VrS0JCSWN2aGRwQkVKdXYrZVdzRHU3?=
 =?utf-8?B?Z2tJQkJhR25KNmFDR2V4UndQSjBvL2VyRmUrdFRjbElhRGIreDZYU0ZjYnNl?=
 =?utf-8?B?bFQwK25xOWtSS3JCdUZ2aUdiMGlUdE1KOEplaDZwUEljYStSeG12VTJFa2pG?=
 =?utf-8?B?OXo2ck9VMDhyOEZlaWE2OEJhbU84eTZpTENoYlVTMUViamJ4c2Y1aTdBTnRO?=
 =?utf-8?B?L0pManA4eGV0WTVzUWNObUxRTkdXeVNoTm5NNno4c3o5dzZpNXE4NzF4aG5C?=
 =?utf-8?B?SXBBbiszZDBPc3RRWUlCVUJXbGEyYmZLeUtNaW51MWlmUmFrWHNDVHVKcXBa?=
 =?utf-8?B?cWVJWVhXTzd0WWIxM1lGbjVMM3k4OE9Rb3hOT3o0bDYvZTI1amZJVjNCOGxF?=
 =?utf-8?B?b3YrZlUzR2JKSy9BaG02N0NxME96OUdHSThjTEtyNGZaSVZoREdMbWp2NDln?=
 =?utf-8?B?amk0YzBqWGhjUWtiamhjZW93MmI2NkRCYkw5b0Y3dkhSYjNsazBxdlNjTHMz?=
 =?utf-8?B?ZGFZTVBzRFh0YU1rSjRReG9lY09JRFlKYmowUy9halFPOFA4b0xyckhZSGNV?=
 =?utf-8?B?TGR4WjJEQUxYbFVIV0I3Z0ZBV091cHVvaVowTzJzeDVMWkJ3UWppbzJJWWxY?=
 =?utf-8?B?WDllUEJNK0JLM2tPYTFFeFFmSXlVejRpRTl5bXVhWFVOZU5Uc1p4VGs1Vm9R?=
 =?utf-8?B?aE95bW9memZKclRmdGRXamlzLzNCeVo1dTZZWjFjZmJMNTAveStaSUVxQm4x?=
 =?utf-8?B?SmxZbmNTTytHMGlRNlRVd2xUY0tjYTArK3JDK3NkRXBEZmdJN3UreFNjUGJq?=
 =?utf-8?B?VU1udjRTRGx0ZjJybzVkTTJBaDJPc1RaS3JTTWhnT3R1d1JpcUhtUkFoNGlL?=
 =?utf-8?B?V1liTjBDMDJwM1lKSklMWVEvMElCbWgvcG5xcU1haW0vK2UyamZHNkovUWtl?=
 =?utf-8?B?ckllYmVPMWxtV0txcys1Q3V6bzd2NUFHZnBFWXp1MkwxU0tnOTRlYWNOYzFk?=
 =?utf-8?B?VHJySzIzSXdscFovbi81MDhvcmtjcmM5WHlLNEQ2Ui82c0k2MUFmMTkvb2pv?=
 =?utf-8?B?bnlmR2Yyc2JOQnJ4RFMxbllNYTRmSXY3eDFNcjNKV3Q5SDB6dXJLNW1MQklR?=
 =?utf-8?B?TUR3aVJKb1NFdW9nWDI5WWE1RzU2cG83YnRrOWZnQkRyU2I4ZTYxQ3JrUWF6?=
 =?utf-8?B?ay9TcFFWRVpzcGJSYXF4SUp4WUpnKzA0OVNIaHN2NE43UmEwVHB0Zjhtcmgw?=
 =?utf-8?B?VkpPUnlJRHBKZHBHLzBDRGxGRHdBalhGMkR2MlkzcUlOZmNKOTl6Q3lvUFFQ?=
 =?utf-8?B?KzNHbjNueHRGZUVPZy9uUVNPVjBhZHhnbHV5TXBoNytmMkVTNjh1WmRGeXgw?=
 =?utf-8?B?RmNjSEIwNnpkK1ZZQ1ByNEtvU0p4SGcvUFY2OHFJSlRrU2V5Z2c3UEFkN2RI?=
 =?utf-8?B?bmV1UXVCRXpuQmdwSEtJbWVUbndYQ0RsbmhYMk5HbFJjRktiRndvS0FjdzZa?=
 =?utf-8?B?QWp3dUpPUU5ZeXRxbGhQU2tQaTFNb2Irakk5aVIvQi8xRVM1ZktzZ2QyQUh3?=
 =?utf-8?B?U25MVlBFTGdrbGxJYW9pK1BhbWZ6aUNicHBLUkoxTUJaKzlnMFdQRVZpOGt0?=
 =?utf-8?B?RTFGcVVlVGhjcmFkQ1Z5K3A4NFEyd3A3MWRib0laVlJkdEF4bXNESzUzb2tq?=
 =?utf-8?Q?T5iXfbiJoopaSt8mxYtc67GGB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b74213-1de2-45b2-503d-08dc2c32e618
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4119.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 01:27:10.3502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keMuxxY2Vovoldgo9Aa/f9t16xO3dIleIunjVbqlG9Djqb71VJHoB7cqQnsuLSPTN2Gt7u2JM2cP5rjchgH7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/13/2024 12:07 AM, Kees Cook wrote:
> On Thu, Feb 01, 2024 at 03:28:45PM +0530, Srinivasan Shanmugam wrote:
>> In "u32 otg_inst = pipe_ctx->stream_res.tg->inst;"
>> pipe_ctx->stream_res.tg could be NULL, it is relying on the caller to
>> ensure the tg is not NULL.
>>
>> Fixes: 474ac4a875ca ("drm/amd/display: Implement some asic specific abm call backs.")
>> Cc: Yongqiang Sun <yongqiang.sun@amd.com>
>> Cc: Anthony Koo <Anthony.Koo@amd.com>
>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>> v2:
>>    - s/u32/uint32_t for consistency (Anthony)
>>
>>   .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 24 +++++++++++--------
>>   1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
>> index 8e88dcaf88f5..8323077bba15 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
>> @@ -206,28 +206,32 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
>>   void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
>>   {
>>   	struct abm *abm = pipe_ctx->stream_res.abm;
>> -	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
>> +	struct timing_generator *tg = pipe_ctx->stream_res.tg;
>>   	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
>>   	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
>> +	uint32_t otg_inst;
>> +
>> +	if (!abm && !tg && !panel_cntl)
>> +		return;
>> +
>> +	otg_inst = tg->inst;
> Is the "if" supposed to be using "||"s instead of "&&"s? I noticed
> Coverity complained "tg may be NULL" for the "tg->inst" dereference...
>
> -Kees

Thanks Kees!

It is fixed in the below commit:

commit ccc1e78470efb6572a71ba88d70995e8eee2f6e5
Author: Dan Carpenter <dan.carpenter@linaro.org>
Date:   Fri Feb 9 16:02:42 2024 +0300

     drm/amd/display: Fix && vs || typos

     These ANDs should be ORs or it will lead to a NULL dereference.

     Fixes: fb5a3d037082 ("drm/amd/display: Add NULL test for 'timing 
generator' in 'dcn21_set_pipe()'")
     Fixes: 886571d217d7 ("drm/amd/display: Fix 'panel_cntl' could be 
null in 'dcn21_set_backlight_level()'")
     Reviewed-by: Anthony Koo <anthony.koo@amd.com>
     Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
     Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

-Srini
