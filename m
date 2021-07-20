Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20015C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 20:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D311260FEA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 20:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D311260FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782996E52A;
	Tue, 20 Jul 2021 20:49:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE166E52A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 20:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv62ftleZgznGe6e/rim9Glj350PPLE4yVDMG3taD9Evhcday8OGsjQ0MkZiSBSaI6X9cMhXsL3zmwVoc+1jIjf+FdKfc+253BS8s4uo+GRs4O08HhOeCb+ci3Osb1zcIGNOHcghx0oMy/jrYeloTzVLFC/cuj2I/308aNxKm6zhxTNlkXKrjGq9mE/egh7UDlHcSSOWtiJ9oaSwJHaN9aFxbNCKpw9VvI/LiSiDajKT7kWU04qiCuf4RlCnahNkps3coofUsrJMpPMwskdtmnWTIXQlN5UD6agrnVuHeSotsDqFjqJqSzHkUr9oMHVSav6YROAJff5Sol2NpaySUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szgGz9pWnFIwEnA1+A++KNtOSQ76jHjH5TPL6XfeLuk=;
 b=P4/Y/rl5eCX5LHi7KTU8JRjR2vJnKmJYKL9x9/DZsg4feDfy2M3MUKeck8MWLVgkpE/NL7n1qk3wpC77jiIgZtzorAr/eZVihVGbsMkyk/yzBQCYBbd2+wxnMWk1vtllifip3z3JYEcgKyCGg1HZbWo4jRPFQGqSOemtdPxhlVzX/Pulxy+NiO6wkY1mRBIlhyE/cmgv6Fn+28KHYaxpSBdXKXTkKJKBHnW3VzVmVjlY3JFyM6goaDwezH2xS0ruXUh6jCwrXH/CMPAt7AU4GUkn1j2YEENM9ss5tyQlVQLDUlTET8hV0JhZ+i+XpZU2hrd/aDs9xgNXZEajgu4t5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szgGz9pWnFIwEnA1+A++KNtOSQ76jHjH5TPL6XfeLuk=;
 b=yBLDQlt4x0vkZkbWTbJxFooqTcVqKVDGZ4YgPQFFsCIRQMUPD+W9x0iOUen99lHwz/aRWnkHZdGudBC8sqogEI4zjkClIV2zxg0Z6oCBMIuvXRR/mYKgbDLAVCb/rM1DhnanyJwb5MxgMUSIn5p+eQp5GECTR/NLqJEM/y5cbfc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 20:49:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19%5]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 20:49:14 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Add a new line to debugfs phy_settings
 output
To: Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210720154504.657918-1-Anson.Jacob@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <a723a953-5dba-d4aa-6a5d-9da547cc195c@amd.com>
Date: Tue, 20 Jul 2021 16:49:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210720154504.657918-1-Anson.Jacob@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 20:49:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a0972c0-fc7a-4a1a-7957-08d94bbfd5bf
X-MS-TrafficTypeDiagnostic: CO6PR12MB5473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB547380E67F43F6BDBA4046C68CE29@CO6PR12MB5473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqOKogyzT3FseV3n31R+7oUk0scc6w6RpgOpzInS26S8AQh3TKOd9LJZ76ThgWoVz8p0u+ZWuWu+naNlBdRzQzRD/bCMjxx/Yg1zo+bqfv7QtMtzy7V+5KLqBfsH5gGw8vbSTdfoqCEzPaNy0HXhSDsg1BnilukViKDj8uHlvuft66B7Nj7MM+VMNW/Z5cI9kWaRfzQVZ14MG9gQkJArLRiTdMUnBp7EruGKvziKE6OjJhMHWguXiBTLcl0JihBQTpbIAdMOe1TZvuunND8dJrj3qlAFVIveEWBCuMf83sNiOqXWgSP3mUxfrvQj3MmreSNlX6Ix5AA9wR4rUMAp3GVGOx97IcHEbhSOFZr+yJuIEIH0PeHBrdPDoYb9u3JWfecQzFLAPX4+0HYCaLZ2JDmL62TF6Ml2s7+m/5ctn5l+R5ci6P3BMYuDdqwSyWc1cPIHHPxx4GtJ28OnQVEF8Wfsvld4TMSC0/LtIMSof3+BLLSHMeVW4JVnopWT+JFn0s5BAj2inF9M871KUqeL5MPDNK5d5ELoBSBkflgkUOlnszjWKJkLJ5ykyVQgH/0JnPenK4kRM9wcufYOEyX2rn4HBZn3rSBjJjdjgdRv/rJjdPRN+MZj9txHduQH9wUuBhQ+yW2V/DJtShnlVshhr6FrAGoP5bhcdhtoKCG21GwDJy46suPXQy8OZ6awEUFIKrEzufK4ia0UOLiQwosiFySMjZYxJpVyds8zT56p8tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39850400004)(186003)(26005)(66556008)(66946007)(44832011)(2906002)(6666004)(316002)(478600001)(86362001)(53546011)(4744005)(83380400001)(31696002)(16576012)(66476007)(8676002)(36756003)(31686004)(5660300002)(956004)(2616005)(38100700002)(6486002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE8rNlplYm9oRkszcGtIMjA4L3RrSTVLVVRndDE1KzljcnkwM1QyOEZIeUt6?=
 =?utf-8?B?Y1NzRmhoNEJoR0dzdWU5bVRrSXE4ZkhFeWx2djRKTEVBd3FrbmF6ZkFXTDRH?=
 =?utf-8?B?OURZeVJIaWJDQnZLOGc0bnhZK2g4SlMrSnFGV0dVWG1vb3VyMU5xM2hybEFn?=
 =?utf-8?B?SkJpajNPdnpqRlZQeG1ONFdvNTJHdW9yT1hMTmlvbmhDWUJLSGhSY1dBR21j?=
 =?utf-8?B?RG1kU2txZVl5cjhEdUtuUXp4ekcweU5TRlB2bkxuc2JZcVhTZEJGMUlITy9t?=
 =?utf-8?B?ZU8vNFc4RmRyVFQ3OXVQQ003SFA3dUE5Y1pidEQwemVVUVZ6ZjRsZFFkWmlw?=
 =?utf-8?B?b1pPUXpwTy9kN20zRzQ4ZXpaNWRiS1FiWHNHOERZdXhhRFp0bnBTNHZHVXVk?=
 =?utf-8?B?U2dEWFhyZC8ybTVhY1N5LzU5ZTVNWVlGb003bmpxaElhbjMxZUIxR3UwVVB6?=
 =?utf-8?B?Uys5M2gzdWRqbXRSby9OdkRwSFlGeEdyUnQ5WmttMWJpRUlPaXJkMEFRUVB6?=
 =?utf-8?B?cm8zK3ZseDJ4VzByTFNFVjYxaDlhV1VjbnFNcjI0ckFIb2dLVzFSTmJNYWN4?=
 =?utf-8?B?U0s5bytoUFZpZXorNXhOcHdwVTdnbm84TEtBL2gzOEV1V240NTRFWk9PaFZi?=
 =?utf-8?B?R0hDYUg3RmhRbW41QkFPbHM1QXlweGNqTzZJNjRYZENIcEVDRW12dDBWcUlT?=
 =?utf-8?B?NUZaWGRQdjV1b2E2MGs5bUVUWS9DaXZ4OXBNNFlNRkxMcjNJZUt0Kzgzb0Zt?=
 =?utf-8?B?U1JwL2ZIS0xOc0d6L1F6bGRRaHlCZDlBVlRBRnZ2OEU5NS9YSGk2NVlWQ1ZN?=
 =?utf-8?B?T0lOaXdrRnQ3QTJXcHpuVGhpV29CZVZhRVMyZFgxQndCK2FDNjI5OGpOZXQ1?=
 =?utf-8?B?WmlGREtjVUZOUktZUkFTY2FGVnMvQTQwV1NDNFpNWGZJV0ZLdGEyc0JKK1lh?=
 =?utf-8?B?RTJ0SUxacC9JcVk2WFY3bjJzUjM0WTVBU205d0VxTCtlVjJ3bVVrR25hVElD?=
 =?utf-8?B?UU1uVXVHcHd6OE1kUGZGTVFodFM5RVBDRkpIREQzdStLVHlnUzV6MDRRSmor?=
 =?utf-8?B?WnQ3ZDRCZG1YekZzbGxEZ0lHVGJRSktQcWVRVkFzT2x1cW0xYXN3L3BSTnBI?=
 =?utf-8?B?NUFSWGgrN2NURWZRdlJ0d3kzNE5CYnFtZUtobUh4UERRb2pzUmpac0dsOVJY?=
 =?utf-8?B?ci9PVHdFdGpTcFBiWFQzQWJuVjRrR3RyUkpVaU03c1Q4d3QwcnVqanl6WWVr?=
 =?utf-8?B?cHUyQW92S2dPZTY3NG1HS3hScStXdE9SRzJxYkpaRHN6UURJWEdMeUVFR2pG?=
 =?utf-8?B?TUdvWHhlREthU3ZSOEN4WkxDclY2OVFNV0o1eDBhWFhRZlhFbWhORWlyUExI?=
 =?utf-8?B?SitEbFlDSU43ckZoQmlIdVV1MmtIeHAybG50MEdxZklxUW5mVVdvVTc1Z25i?=
 =?utf-8?B?cjlIMlVvQ2pqNkl3RXorUDFzOVVyMi9YZHFYRnpvN001NHVmbGNzT05MdUhM?=
 =?utf-8?B?SDhGWXRvelZDNmNxZHFIMmpONzdoSFdPSm8rVFBnbHp1VDNlZVQ4REYxQktr?=
 =?utf-8?B?c3AwbTVuNmRVNGJhVUwzS0pPSFExRHROYWVGRkpxbFJTbGM2WFlDTXZvUWRz?=
 =?utf-8?B?Vy9tTEsxeG1pQ2dZd0k1UXFOV3A2R05UMURTWGVVU2FiWWJZcjYzZUpoWUJR?=
 =?utf-8?B?My96c3NpbFRIRmh3bnlzMUV2eDZJV3JOM3lRY2gwOFZ4NGdiZTZ4dDA1L0RF?=
 =?utf-8?Q?HR2Irx+fpqG2AZzzL7BHkPYo91e7xYVqsRyL4rK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0972c0-fc7a-4a1a-7957-08d94bbfd5bf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 20:49:14.8882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxIBqn3TnXFBOjgRXhXgfj5cV11F0bzv5WAix8BTl9rnEsS38RrXzlXJRLQH4iTrmcDcOLqTMvPW+LNBkJGOaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-20 11:45 a.m., Anson Jacob wrote:
> Add new line to phy_settings output
> 
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 1d15a9af9956..87daa78a32b8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -377,7 +377,7 @@ static ssize_t dp_phy_settings_read(struct file *f, char __user *buf,
>  	if (!rd_buf)
>  		return -EINVAL;
>  
> -	snprintf(rd_buf, rd_buf_size, "  %d  %d  %d  ",
> +	snprintf(rd_buf, rd_buf_size, "  %d  %d  %d\n",
>  			link->cur_lane_setting.VOLTAGE_SWING,
>  			link->cur_lane_setting.PRE_EMPHASIS,
>  			link->cur_lane_setting.POST_CURSOR2);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
