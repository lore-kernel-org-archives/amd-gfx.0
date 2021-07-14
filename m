Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA6AC07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2042C613CB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2042C613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80A2898FA;
	Wed, 14 Jul 2021 15:13:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBEC898FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3NW9RwvZ4Th72PLgKV6huLhp/kTl9WSUafTOaNyLEhvm62TlJE+2SX6f/NLMwECdtta4Aaj0/Ryf3AzbJE7bbjXrcmQ+TN1N0puDi2iSgGxYBW+yLWheFy4EyxbInEt5tPFivOV40kxWez0TzFMCxTmzkiFIEMPBI4InGUZD4uUvYIgTFPdJaBp+LQJihc0on7u2/Z9Ui2KONy3IYwn3TxxdZxcnEDaFjTyJWRk4Opi0yFkmi/0E9qVZ6L1UMKuS4Qp+zD3QtXlDSfiMrwdXa77qkU5K+PkMGVY1eqycnvrEt/LOd2Z4Oz65QDuqbNhGjZBYtRKGsrGmNtE/rLDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRmOzZdr0zlpJmSfWkEGUeVTWnwqHwGPRhTF6TSyhk0=;
 b=Xvcuiwx3nUs1wwF2ZQXradoOLXLupy/Hsr8Cxtpa2phf8tUBUNMo3IOCoVt9qDiHNfNv+TueDnsB6ZD9cj5JWkpLLfZRIjKo2SL4ALj41f9S8lYUchrMpsuXrgCVQV4DjjM5wGoxztcTG2JkPJYaTcdfiTcBjJEin7nolfaX+7c8O+6+cgVEyXaAft2VHGE3Wdac0yfgqJABk8CLszwS15XCAAVcDpV1BIdzb1fxLOKd8n4LnbXp7LG6UvQ5uNeJ/pWul88+pYBARIpmlX223MKMUeRNYkVcFA+NHr/xfMlLQi7Dk78PnGW4SGxMcl9aPt7tmPddAne3BSb6DtBUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRmOzZdr0zlpJmSfWkEGUeVTWnwqHwGPRhTF6TSyhk0=;
 b=fsmZg7bNqILD61ubE5vHQBgF5o5H+eiybHCvfKb4XASuiGzB1jgBmS4+tEMxlbfOWePXiaA3NwprtTdaa9S9vNMg1qpdVMoaAUUPd+jmpdMt6654aJNKQ5r0w0/I8Ak5mieEtPmkO3qkkXSPmVncUmA3ktdiKPFfs9kLvX183Rg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Wed, 14 Jul
 2021 15:13:46 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 15:13:46 +0000
Subject: Re: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA
 parse(v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 stylon.wang@amd.com, Nicholas.Kazlauskas@amd.com, Rodrigo.Siqueira@amd.com,
 tianci.yin@amd.com, jiansong.chen@amd.com
References: <20210714083901.9312-1-guchun.chen@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <4413dd86-bdb2-1efc-b8ea-c58111951478@amd.com>
Date: Wed, 14 Jul 2021 11:13:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210714083901.9312-1-guchun.chen@amd.com>
Content-Language: en-US
X-ClientProxiedBy: QB1PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::23) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 QB1PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 15:13:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce8a00d1-eaf5-4ef4-c2ad-08d946d9f96e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5492:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5492E20C1CEA045ED5C577618C139@CO6PR12MB5492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0I1MtwW66JcXNv9eBRjZU+TxxUSIvqRky0k8FeyJSCrF7F9a99ffwQ7aQ9KLb6UMi2ZkPZhkFYLetacyzCirnRxtzX/M6HBwnaUcCBnMTtqm4I61fPYksmJwbSj24RFM+0CfflVTJDCQl2SALKY+/t6I0mF06Se3eFU+YoBGU1gnZ2TFgOuUNAFG9zXy2NZjxTNmghgGh5ghYVMV/zV1q0s4jToJCKR0o4Y6gfvv0fTK2o2CnCByCErVCoWgmqSV/UdFiUF+XQ6Bda1LmlO9mUvhLElLQAuo8f8AQqLaD6WUN0Tj05QCvumQS7VVzfoncUb++w8t3m+0fRRcTD3UO3dOh/ear3f4utaT6E/VhFYOEknrsWAoBzFoKua3ZwLnPjgookPwd7hXRVKc0tnC55jb5/FM2QEbg/ltEyTUR6HoRU3p6Ex8Gm3SqWEtYq40DqJ+XH7b7guaFqN12cobvklxewHB9nj0ZrWW9TiG2kGxbpmzSIOD7AAwyG6jah+bvh1bssow9uSe9a/kcDXfntLitqFrAt6eiOv+yFhdcUy79UH/MWqRhyq5oNy7NrCzwKGqo4WiehTHskohYZqxM2rRsWQ4YXDT4+TpThrLKVfdTUTno3SpufJnEB7PKiJaGIQsFeP6lVhUx6pgQ+KgflmFkKhlE9GF9BjYjy199JcMWGU8O3ryAX/lfBTo6y45DKcYscPruMKtQJfdzw6F0gzra8/QAOsCOqZD0/w1SM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(38100700002)(44832011)(478600001)(8676002)(2616005)(6636002)(31686004)(956004)(26005)(53546011)(186003)(66946007)(6486002)(66556008)(66476007)(31696002)(2906002)(8936002)(86362001)(36756003)(83380400001)(5660300002)(316002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzBJOTlJbzRnYVBwaS92VC9VaXlpTVM1Zlo4V1dpa3NrOG9PQWltUll1dzV4?=
 =?utf-8?B?ZzhvRmsvK0JRQlVONGU3QVJIOHprM3pwRFNDeW54T2dWcHl5Ny9IaGt4THpt?=
 =?utf-8?B?QWJEZ3hJTzVpajIrQ2JOVHRpUnlpaVlKUHl1Qi9jN0lWMHVZYWF4V2w3bkFU?=
 =?utf-8?B?OE9pU21yWHFrRHQ4ZWxtTmxzS1k4ZnM0Mi90YUhDVGV6akgwNHAxbkpqZWJr?=
 =?utf-8?B?OXpLb1NLUzNOZFJnVEZ5WU5CN0ZDR2h2TW5Pay9zL0t2c3NxeW9SSzV2ZGxy?=
 =?utf-8?B?OUlHVWVkTHQ3ZmYwelhrZnRvREtwT1M0K3lHd0FaSmhzN0VyV0t1bzRSVkVE?=
 =?utf-8?B?VTlCRzRDUWdxaU1xTDllejdtQmdjMlpCTWltV3JCeExkSnljWkJqNUt6Skh0?=
 =?utf-8?B?Wjl5Q29TRysyZXNselBZMTN4MU4wRGJ2SjRWMDI5MGxhWWtBREhjK3dzZ1pi?=
 =?utf-8?B?a3hsSDhvd3RaL2N4ZmdiTVdjNFJNclIwUE1EeFJRZ0x6QmVpVjdKRTlDRmdO?=
 =?utf-8?B?YmhaY0dseFhkVkRDMm92Y21BSXl1QzQ0L0FVT0hoZkV0ckpHZ1JlajVMS0Zv?=
 =?utf-8?B?eFNlOXUxajE5OEdja0JOUEluYm9IRnJDSWlEL1N1Q2lQTyt5dWpmeENsbFNx?=
 =?utf-8?B?SHUrelkveVV6L0VIcVpnSFQ2K2JlNVV5U3dtTkhSeUFJb3NWenVmMFQ5Z01F?=
 =?utf-8?B?VVZiREtLQ2JVdDVNa0VaWEdmU3NvVGJlUmxaUkF4NFd1c2hHNWZxOW05QjdW?=
 =?utf-8?B?TStlRGZSSzFTMDBadE9Cd0svcFF2czh4QUMrL3lGbjgzZFVFalVQRkJ3VkxJ?=
 =?utf-8?B?T003YnYrZ0hDUGNua1RaNUdlSmNqZDlwMkNiZDZobHNyc1VvWDNiMzNLSG9U?=
 =?utf-8?B?S3M1dHNWRXNuQUhRTUQ1R3ZnZ1U3dWVrRzNLdFA1NWNtNVZ5b1Bna3FKRUNF?=
 =?utf-8?B?STJSSWd4TldpYVowY2JYSmNiYjhaSU1SVGRiVGZTSEtab2JNQnZTY0grbnF0?=
 =?utf-8?B?RThMcCtEeDJtSlRFaStMNlRqVkVCT3hJVlRRU3IzTFhxRnlyRzRCYWFDeWsz?=
 =?utf-8?B?WmIyUUdPbXUvUzNkckhJMmxmOFVkR0tpa1RXKy85SDB3Uk9KSXdDM3Azemg1?=
 =?utf-8?B?T2ljdVBFU3NvUmp2VU9ubmNLTWhWenFkYkUrbFJOdVI2NkhIMUJSZEVDaDBO?=
 =?utf-8?B?YlA2a1VsaDhCaGtUVXNkQ2tQcUpiQ21oTFNXTjJnR3dYdXN4MGdGU2dZQXZv?=
 =?utf-8?B?ZWJlczBmalp6RjB2YUlZM0dZcU5IbzlZMjRMWVBTeVpodnMyNFl5Q2JWam1u?=
 =?utf-8?B?bU1DTE81bDFKa1V2eEN2OFdQNGFybmVSTloxelFtbDAyRkx0K2UvcGgyRXcr?=
 =?utf-8?B?dDduTXJmWDZhRTM0TUVNcmdRbXJzY0dnNWFzdzdQNmZpaFV3czhsNWZEZ3lK?=
 =?utf-8?B?V2pFR0hLTFJIbmdiWWJkbVQ3eGNIdkVNcWZQRUNzMStLSUp0eHJtYldObVcv?=
 =?utf-8?B?SlM1ZDNxRTZHQi9PbjB3b1g3MEc5SWNFdENyVWM1S1lTRzdYK0FNOUY3RVR5?=
 =?utf-8?B?TW9TZlp0T2V4bHB2UURUYkFzVGpERWpkWk1LMGc5T1JxbHJ6QTRxRkRVKzhi?=
 =?utf-8?B?RS9hTmR2U0lCTDkxZXYwUzBSU0Rkb2phampBcGN0UU9DNTVkelFBWTBldmRO?=
 =?utf-8?B?VnlQK203QUN4YnYwNVlPWFNOajlienhtR3pWSEo0c3lCMDVaYjYzelFMYzdP?=
 =?utf-8?Q?Q37owy/hTARe7GWv7wB6u2GPsAx4Aost0sGKIgT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8a00d1-eaf5-4ef4-c2ad-08d946d9f96e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:13:45.9136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIIorh/XQwsNkXZIdBhyaSIG9vyEOPeAOgDYPz7CY9Medz44bE9at+rDdDCY5Uca6USw2+/yOshW28zF8E9ECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
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

On 2021-07-14 4:39 a.m., Guchun Chen wrote:
> For the unknown CEA parse case on DMUB-enabled ASICs, dmesg will
> print an error message like below, this will be captured by
> automation tools as it has the word like ERROR during boot up
> and treated as a false error, as it does not break bootup process.
> So use DRM_WARN printing for this.
> 
> [drm:amdgpu_dm_update_freesync_caps [amdgpu]] *ERROR* Unknown EDID CEA parser results
> 
> v2: Use DRM_WARN to print such info.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 03db86bfaec8..f7ed4d20d168 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10700,7 +10700,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
>  		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
>  		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
>  	} else {
> -		DRM_ERROR("Unknown EDID CEA parser results\n");
> +		DRM_WARN("Unknown EDID CEA parser results\n");
>  		return false;
>  	}
>  
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
