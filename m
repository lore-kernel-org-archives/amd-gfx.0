Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB8C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 15:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2405164F87
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 15:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2405164F87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36526E06D;
	Thu,  4 Feb 2021 15:17:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4393E6E06D
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 15:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0SHNQOULTkv/X/hJTgAwX1awlM+5v6i3UWeleekPzizbi+ZIocLEsrReSv3H5ln8q3qlZaGVps++0e1HkRCQRnvxxyTEFlINt7ifRHlPM2ZUuEtZ5jU23C8HeW8GZCuSietsrF1FpieNaWzu1XWvPbV41scYsn4XoS63+J+W1ckoOsHulGF+LeQ9GTmSMvMMykTLlJsOFKCSKrqux6g2wzN0P4cHZAyjCoybbHY+E/LDqHgd5XL3sos0jO3YBCT8H6IJi41j3SzYlyLfr1WvfHs7Sjn7rs41yRpBuTqSoRrP3RhM68YLK30M0bKMVSTxJTDI8et0kGy4abl2wUd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j4dC9TE1AHEJrQLU4M9Ibbw+xEZ5rv+6FBv1HljtX4=;
 b=SwQdV0PgsieO2ZEblF0dyUwu55rAu1ABcyQuXDQVYCk75vsA0xryxIEEzmVCtlWynKzOZLHeJBGHB4CS1kweQjX6tNGWfnnUYbgcy2GTXN6f+X85Q9+MdamICwRPT53YTaAJo9AFBDyCUtDFLy3H2F1QUtGpCUPLzZ9kUqVztfb7ElUDvRRLgnYPPQIbi7ElJldrs/ETko/cAFzRzIcwd+u4J7AIHLyjsMiKw9UCncIZZPYRth/eKqzohoKOj1W4PVq5YS1Rj5cNQfAhX1vOv7CrT3iGHHL8utBViFuc1E/Mbm1INFTaaOtUOpYx+Ug8sMRM39hYITziryPe0jM4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j4dC9TE1AHEJrQLU4M9Ibbw+xEZ5rv+6FBv1HljtX4=;
 b=xX7jiHaomHS2F3GvOjAPMaWOAQIpv8vHSr6WpcQMu295JH1aw4t2S4rUfK8cIYDcsErEOrkeAhQJRgUx/xnnN5nrOGP9HTaXkq4Eg3ZjjYq998ncWH7/yId0AroCz960aPoR4A+WltZMsZnvn6gvlkbYzrTbTGpPr9l6AzNt8o8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2356.namprd12.prod.outlook.com (2603:10b6:207:4d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 15:17:29 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.022; Thu, 4 Feb 2021
 15:17:29 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: use runpm flag rather than fbcon for kfd
 runtime suspend
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210204144329.52506-1-alexander.deucher@amd.com>
 <20210204144329.52506-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4b007e1e-0360-0c2a-df8f-cd195e130b21@amd.com>
Date: Thu, 4 Feb 2021 10:17:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210204144329.52506-2-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::42) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Thu, 4 Feb 2021 15:17:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d9517c3-fec6-499b-1c23-08d8c91ffcdd
X-MS-TrafficTypeDiagnostic: BL0PR12MB2356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2356B946E47BF27DF6AB0F7E92B39@BL0PR12MB2356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlVAWuLN/56LVcT7gSNdtkbU/ZucpCGmoKjaITz9fFGE4h+RXQyqOhEbia6rZH9vVus+HJ5eoWi1kl9A/cquPKtaAHR3LVKQUD/8rvLV7SLCbPptDEtlPgpc00cEPX2/7wYkr7RFN4yfvcbKfnHJNU95K9zgyE8CWLQ5Bc3IOBJqaUo7MfhToRRWY0qd89YD3rmeMJR7YSxj4naifEAy2gu9zf9pw0pmOPwuKchV1CNykRQ1S66JUCdOx+pjZ+F45Gded1O+dBHyJjhxB9pjCC1Mzum8u5BvxhQ8UJpj6fPz2l+GM1IZ+I8g18VZ6Vce3PvyQY9zrCiJjoS0dpojW+RNJztbOuex9rexyKe1xO8Lt9x7cKEbjEKrFX/01L+dezkdzgASdm8RQ0eK7qnOHw/l3HdtQA1qdOG0b1fvGcgCCKPVgBXKUXHSlhJStmDgGXEGXpEYvcT1AgyT3crDiyOf48uNK02uSjfI5CxAA2qoroYYxQgkJQrTn5BIWsKijs/vTKh2ANib3w/v9NduDmml4o3Y99FVDnyKsF7j9lU6WQTB0RhLFNDscXiJIXau5KMRpdUFgo8BHI+73z2xXKkdvuiXw6W7JuELx+r43HU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(66556008)(8936002)(4744005)(31696002)(5660300002)(83380400001)(31686004)(4326008)(186003)(86362001)(66476007)(6486002)(26005)(52116002)(16576012)(316002)(956004)(44832011)(16526019)(8676002)(36756003)(478600001)(2906002)(2616005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OERqWjZtMXlHcXFVTTUzZ0gycVFsVmhsMWVzcVhsdlQyUGgzYlFuRTlLOFRN?=
 =?utf-8?B?QU9JSXJZU3Z0OFdGUVloZzd5VmhwRDBFeTBPOEFvd3RLZ0RTSitUSWV4Mk54?=
 =?utf-8?B?QldOQkNPSVhrUVVaVUZKRzVVVHpuWUEzVFhOVzlvTkY1VWRPcDZxYmw2bjZp?=
 =?utf-8?B?K29FNHh3OU9PZHl5dlVTUjlIcTBhOUtjMitkbjNxUVVmQ0tlZjZZR0lpNVJK?=
 =?utf-8?B?SURZS0t3TDBZVWI2Vk81MXhMRWs1UFRxdXpkWktUN1FRV0JORjRJdGM3dUpm?=
 =?utf-8?B?LytQWVgvNk54TzkyYktZL2lmc0VTSTJPSllMNG1XeDZhY1FwR28xVVFzOGtB?=
 =?utf-8?B?RXZ4MUxMd1A3YlQzOWRyNG9CMFM3ZmNpTC84LzBGbFZTT2IrZzhxUkdyNVNR?=
 =?utf-8?B?bFVXUndpa0hwVTIwMkVDZmR2dzg0dkJ2ZHdPcUo3aUhRY2MzQVdvdDlyMUZt?=
 =?utf-8?B?eEppU0NPMS9kVDZobkt3czFubUxaN3FyTU5pNmNrbXdydWI0OVdWUG9jWS9h?=
 =?utf-8?B?VDJTZVNuOHd0WFlaYk9QdFpBdUEwaXdUQ2lyT05BdEs1QVhnZG1lTDdQTW11?=
 =?utf-8?B?b25zZEhHRG1KNzNVeHJDZjFtdkswRjlodFRsbFBFY0tiUVpoQnRab2VWK1Zo?=
 =?utf-8?B?VSsyUDBYVERkalVkR1lWQWVBa3Riem5qMHhTVTQ0STE3ZmhrL0dLdFJxSmFK?=
 =?utf-8?B?cEVnd2M2MUtyZ01qTllHTGNqclZKUzdHRlBzV1JGeFZ4ZkpxWWdTdkhIcm5J?=
 =?utf-8?B?NFh4aFlUMkZzc1lLaXZjcE1BU05Ya0U2WFZuMmdXdVlmMkh6TlQzeWpLczBL?=
 =?utf-8?B?Z1JwWkdmQ2hMTE1Pc3ZvR0w4YWpYSk5kb050T3RWTVNTeFk3K1U5UXkxR0ZE?=
 =?utf-8?B?NEpUT092Tyt0azg1Sm1oNk5rcXhWdGxUeEtkNHIrRGQrcG9OZm96SW5vSHpa?=
 =?utf-8?B?cVVwcU9lMk0rZXlkYnRzS3F0dDFNQ2docVFOa2RhaU5MbWxWOGRvNkZZcHZ4?=
 =?utf-8?B?Z2dpWFQ5MFNESFNOd0dNWWs2bERtR3gzYmwvRzYzbnJHY21WMG5ZSDdjQ1ln?=
 =?utf-8?B?eGF3amxzeE5DWnpLNzdhd2l3M2RKM2xLckg3eWREcFhiTkluYXltdXBsZXBk?=
 =?utf-8?B?WVFHbXlDMm5FSVRtYlpCQnozZ1hGeHh0TGUxZkhsYTVlL0JNaTNqNlkzOG0v?=
 =?utf-8?B?Vjd2bUtHc0VwdXhVVFh4eENMUW5aY1RmNlBnQXNGMWF1WWRpN04zMWhyWW9R?=
 =?utf-8?B?SkJaOU1OSVFnMzNuWVVIWjdnb2t6cXdqdlVEd0xxMjNDK0VjdEl3VDlzelFq?=
 =?utf-8?B?Rzgyak5qdHVRVjJ4TStDRHJXamRpS0dsanMydmRxSzBvVTBZV2M0NlhIWXIw?=
 =?utf-8?B?S081N1dscnoybnRWRW9YYU9GUHZGL1BDK3dmV3draDdtc0w3dFd1L1JZVjN0?=
 =?utf-8?B?cmVWMFQrQnU0ZnFuU0gzbFUxYlppbVQ0aWVIOXRoSmN4amkvUFpBaHM5cEJv?=
 =?utf-8?B?SWh4OGZkVzdVNndBdlVXbk4xSFBGNStFOFpVRTFEaHdYS1NVTkY5VEEvQmxF?=
 =?utf-8?B?cHAvUVV1VXQxWEQ4T2p4dVJwK3gyWndseXpkeEJJdDNONVkwV0tLaU51WDlL?=
 =?utf-8?B?MEhEN0I3allSRmlwbWcvU1BiRGxHYUV0cnNVZGUyVnZ5dHFUZXlic2piTUdi?=
 =?utf-8?B?M0owN1RMNTB2U2ErRE8rMXVsME5kNFh0V2hUTlBla0JMRzdQVU1ua2Ywc1pR?=
 =?utf-8?B?UWZTeURWODJUblhHZ3NoVG04RkMvN0w3Z3I1YUJySzU3NVZQUm12U0s0WHZs?=
 =?utf-8?B?VFJjdFZlNjl5VnV0NXpJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9517c3-fec6-499b-1c23-08d8c91ffcdd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 15:17:29.8086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FV3Tfrrwiz6EMyrOW/jk/h11B6ruRUiJFCMZz+vlrD/AUZyQAeXM4+PYRosResqkUs7dSIG5i52co/cB5HMZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2356
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-02-04 um 9:43 a.m. schrieb Alex Deucher:
> the flag used by kfd is not actually related to fbcon, it just happens
> to align.  Use the runpm flag instead so that we can decouple it from
> the fbcon flag.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 151c649e4d11..053e134b1245 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3722,7 +3722,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>  
>  	r = amdgpu_device_ip_suspend_phase1(adev);
>  
> -	amdgpu_amdkfd_suspend(adev, !fbcon);
> +	amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>  
>  	/* evict vram memory */
>  	amdgpu_bo_evict_vram(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
