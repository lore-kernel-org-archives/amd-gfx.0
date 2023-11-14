Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 14:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744FA10E3AF;
	Tue, 14 Nov 2023 14:31:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA3210E3AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 14:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYTBJyElIcNEcJRLz5AGJzrioZUfVkVJJfu4bMe/U6osmTIlwQl7SIXUL88iCrhBrMjIiLAThYeq3IRdxr7sOaievur+9lVuPR30/y6RIfCKjbzv/P8gZBpsqhz/wouJKGzRDfNXjBQESO1TZIczMpK6JfyW0yy5HP5sHs0Sd2RQc+4ZlLHEHhRxpls2DkaCZ4L0DN8Sf6oJ8gf+8sGqLSwgbiDVG0yLmb0NrJtESFycIegA6NlwaeNZXQ9T9UyIzS5LjUvj/5077KopDCHICyLL7Grh8FpSVUD1TXG+rybV1SGNR5Z4p99VdHRpq7z8eB3lH1AiGWGmaMKENDonlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH7h/GQE58Q+M4QisydJ2wnucxCTCXc1W4GYO1dzzr4=;
 b=kGghsk4alZ4pp7htCqDUnyTEMv5RudTk7B9Z505Jx+f7zHW2ef8ehqfuU9knmpnazekYxPEbbL3TAO+n4evoklsxjWHnvugDKkNXBZlMxdZqYO3Tbsq8cE/3CKrQDjXcRUoSLsQE3WNI9MbXfu4VZQqkoJn/oYJOS6WkT2vQKkwJI5dzZAYfUuAhjOttbrdD27zcjcYsWROLIPQUZ174/g7CR2TNAlpnyGbYA2hPuj+HXqfQadvZJBpovyvpA9qoICzv1Gx3eC0+7pJpKMk4bEHR7u3jAeLFW3SHbORE3BGWpve6cJelrHvFl0iw3lXHOgvNlixwfEiDul8ZetmVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH7h/GQE58Q+M4QisydJ2wnucxCTCXc1W4GYO1dzzr4=;
 b=5VrpkMdW/1BW06pCY/sYdcu6NacVs9+o/tQQqVOD4+Cx6E08CJfnenKRI+/rn1QwUoUOk36hMynXEoGxlUO4Dk9XTkIEC0nYMYHh3rUAC/zyxev6yxkbtcIbU3p2WC4mINvZ+7lnY3y2f0ir1fvNGbwYHMmpUzIgz3YaUzka5O4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 14:31:04 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::5e7e:d568:2bfd:a53a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::5e7e:d568:2bfd:a53a%5]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 14:31:04 +0000
Message-ID: <d911435c-969a-4ab0-b4d8-3be0b8adecd2@amd.com>
Date: Tue, 14 Nov 2023 09:31:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix a NULL pointer dereference in
 amdgpu_dm_i2c_xfer()
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231113200949.2457-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231113200949.2457-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::19) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2d79e4-e694-400c-8e70-08dbe51e54f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQzy9znDVMaO3rByNKb2ojYKYFwNuV89thrjJvPWQMOzsVQYPTY6fnkVIfr73xmnC7Pq4PTjpBiB3TLxr+RJbe7Ee/s56Va+vqNosEHZuE8RdP0sq4D+c8/T9ayFrBKmqlhypk75zMamImPM3vTOKE8M+sTzvtj6Uazg4p3iDkHaMJd4PFKlwKKfalRH9lkR7NISUBuL0wk/zzpGOb4GEg5vq7GahXo5jbApEGe41+ahJHHMgVLnWRopEQWiunpAJnwa15yxs8wkJTzgDhX2u7l1+Q6FCayoDOlq9ZYW3zVLkdAqJ0f+ZaAvPwapLU5R+jKGUu3vHID2SH1Ky+jIY2KJ/KejZvoVYDhG3NddJa+/Q/wLhk5lHuGAeZH4iJQGT8tBtPK9YEbHqJ25lj3Z5efg8iO5BGhL1NcDMVD54KhQ+LR/vHMDeMYhLAjm80CRQIZbyq1b4yG+fNryrD9ePvbKkDbdhp14OBL4KS/OkGKrBSFYEdh+SoZ5plS+X6SC0WTYmiWVMWGh7Pk3GYt2y9Y5kvDzHEqG56/NWdKCfohkENwudhf4WjLybvpNcNOKfTZlpJ1e0DfCfTb+RLqiXXkwF+bfPOIcDpdT+ZG/Jv4DUv/VlAhOGEWn4OUrt7T+ZU1WchDA1SBgcG8zCWZF5LdEInW76MEaIr3oignScjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66556008)(66476007)(6512007)(66946007)(316002)(38100700002)(8676002)(8936002)(4326008)(6486002)(4001150100001)(478600001)(966005)(36756003)(31686004)(6666004)(6506007)(53546011)(44832011)(86362001)(5660300002)(2616005)(2906002)(26005)(31696002)(41300700001)(70780200001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnVKM29UZm90aDFTWG16bjRtZXRBOGF0aFRQamZ4ellFQmsxMGhIeGgxUzZ1?=
 =?utf-8?B?RGM5Q0NYTmVjdGlBcW5NVVpYbFRKVUdyYTBSSk4wN2p6ZUkwNW1TTFJwSHNu?=
 =?utf-8?B?UlRSMlFrekhKenNPTSthTG54UG5mMVVZenlUakZITmxqelFJd01lQVd6SG1M?=
 =?utf-8?B?VGMwWFZ3dDBmREpjRUdGdXhFSTR5YWNqZzI5cGhsalhpNWJuOGxWWjhyK2g4?=
 =?utf-8?B?bStrZkM1OWM4Uk9yZWYwOGxRY3FKTHQ3WmpzUEZibkxCNHRNV3pTSVhQNm8x?=
 =?utf-8?B?V2RqZ2JqaGc1VDFaM3RtQ3VqRzBHbjM0VEd0Tm9OUEdlWTVTTEFCUVI3eGtm?=
 =?utf-8?B?VzhYaVJpenEwY216bStpUzE3amRCejRQUzV4TzlEU2lKZS9WUEptYkhKNnFi?=
 =?utf-8?B?TXZRd0JPMzNmNjRaVXRLM3lQSFZPdmlvRC9peUF0ZEduWW9SbjVaR1NNbDV5?=
 =?utf-8?B?d2tmMDcvOWtBdDRUaVVyT3NpTFpGQVZWSUdmVkdhYWtWcGc5SmxTSDZybFVv?=
 =?utf-8?B?ZThFR01qS3BDSGFmYURXTnpZZnBBZjBIZmU1V2I1YmMrelpvREkraW4rNzFh?=
 =?utf-8?B?WmtqQVVCUjVDdVJlREVLSFgwbWxMM0hvN2VMQUlXWlpXYXY2aXlQK2owNkZx?=
 =?utf-8?B?cG9VdFBHMllObDlCSUFpQzBwV2svU1VuTXZBZXdISGhnUFV4TXFiVTdBdWZE?=
 =?utf-8?B?Sml5YmdXd0czWFlFWkdaVHF1cXdMS1pSaHQ2dHVnYitOSmZ4aUp3NHJDNEl2?=
 =?utf-8?B?bXRWWHFtS0hlSlhNZk0wRDJhbHNSbHZYZGhicDhuZE1OWWpFMVdCYnJ6MXFq?=
 =?utf-8?B?NEltSnJYQlNVaU5GdGp1WTFkN29MRndWa1pSTnZaazRrSitML1gzMi95UnFM?=
 =?utf-8?B?cGFrRW9BZ2wzYnRBejRQaWM2WnVKR29UR2p6NWR0Wm52dkw4bm4wY28rS2U5?=
 =?utf-8?B?bWFHN1owalRjQTV1S0hCTUhkU3hxUFF6L25WNmFIMmZrWkNhNjZFMEgxdVpt?=
 =?utf-8?B?SFJ4aUtOR2pzcUd1SkduRkdNbUNER0p0VmhkbUVkODhuOUVqSXdSZnB1Y2hm?=
 =?utf-8?B?U2p2MDl3WHB1dmtKWloyU3MvZ3RnZDByN0Nzdjd2STJDd3BYR1dvbFpMazk3?=
 =?utf-8?B?RzFmcFQ2VkxlVTZza20xQ2hVUjlsZWpCSzdZWVRlcmppQkM1OTlIalFOdTNn?=
 =?utf-8?B?TnEyNHBQMmgxU1IrU3k2QUR1dWZuSm1kR2NoUEdvZTF3YTJnd0lrd0pTSldx?=
 =?utf-8?B?VmdMaWlZbWNhalNmOEVPcVlQN1FDNzN0WE9semMycGJKQ2ZMTGhLZlFCbWMy?=
 =?utf-8?B?eXFtUTZIY2M3bWFWSERXK2E2cnB1aVJ3MVRyTFBibjE0UnNDZ3RMdGFLSjZB?=
 =?utf-8?B?N2gvSWhIWlZNMGFWRWVQZURFNmM2TjlhZWZibzQ5UDBEczZlWGQ2RWkxbWFr?=
 =?utf-8?B?aDFWMVQ4U3dpaXNBR1ZyN25qYUs2a1NFQXVSRVBjVWdncVM5MHo4MHBnR1FU?=
 =?utf-8?B?ZEVMRC9GNEdXbEx2NllKS1JodE5UVXhVL3hhd3dIU3FZSjl1bG9YVk82M1Ey?=
 =?utf-8?B?Y05CK01OYnpyK1o5RWhVbys3UnBNZ3FNc1JPRWRxRHlvSEgwZWl1bmd6TkQ2?=
 =?utf-8?B?RmQ0bnVqTk4vckNzTEhFZ2diVzhOaHhWQy90WmpwbmlBOHVkU1JGUnpDQ0lZ?=
 =?utf-8?B?T3UzRWNqd2RIWXJheENEZ09YN0QxR2tNaVlPcFNpUzBmcGdtTEFPNnI5SkFy?=
 =?utf-8?B?QWEwb2V6MUhLWDNzMUN1TmRCbzBGN2o5WS9OeXVWVmJoQmxFSVA2Wmx6aFNy?=
 =?utf-8?B?bE5SKzVNRDhjd0c5UThlTlczRVBNRFNxek01UTBhSUp0aVo2SExoZHUveGtE?=
 =?utf-8?B?TnZGNHJjTFJPMXJxUWlNTkNnZkR1NVIzNW5MUUFMYVd4SENKdGpsc1l0NU1Q?=
 =?utf-8?B?Sjd2cXlVUSs2cGlNdVBSUnZSWGhVNXpwRTFkTFJqa2pSMG1vbDhjOW55WEQy?=
 =?utf-8?B?Tko0azRnaURVejZ5MzF1QnJEMlg2L2JHbklKbVNqdlZyMHM2eVJhbDRyY1JG?=
 =?utf-8?B?Qnprc2dJWHYvNUpvTm0zeFBOTE1GbDJjc1RCd3NTbTNTOTdYNU9yek1lNFFi?=
 =?utf-8?Q?GkUcOqdWRujcsXxqae+CwATbY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2d79e4-e694-400c-8e70-08dbe51e54f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 14:31:04.2513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpeQHfxgIffDS+HATc/M+sgplQwrafXNQ9HlYUgSV4f41FhAv8Hav8L6hFYhahAiEhupGF/RDlg3LXv3+Mp4lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
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
Cc: Rodrigo.Siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-11-13 15:09, Mario Limonciello wrote:
> When ddc_service_construct() is called, it explicitly checks both the
> link type and whether there is something on the link which will
> dictate whether the pin is marked as hw_supported.
> 
> If the pin isn't set or the link is not set (such as from
> unloading/reloading amdgpu in an IGT test) then fail the
> amdgpu_dm_i2c_xfer() call.
> 
> Cc: stable@vger.kernel.org
> Fixes: 22676bc500c2 ("drm/amd/display: Fix dmub soft hang for PSR 1")
> Link: https://github.com/fwupd/fwupd/issues/6327
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> v1->v2:
>  * Fix a memory leak
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index adbeb2c897b5..f6b31c108180 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7463,6 +7463,9 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	int i;
>  	int result = -EIO;
>  
> +	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
> +		return result;
> +
>  	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
>  
>  	if (!cmd.payloads)

