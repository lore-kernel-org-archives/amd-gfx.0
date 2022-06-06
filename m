Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D331C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 14:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47D810E501;
	Mon,  6 Jun 2022 14:05:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CA110E501
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 14:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgCyRWe9tIclnR/eE5sTRZMGG15yx67RiUwloJoKSjIoDOTQ37CV1kj1TxjXIhdVKtTAVufi0nET+/n4Vhw+O6ivDyprYcJmrDPzs/HS7/DE2ogjVLiRd6FljJHM2h7yvzwcOmmxtccm5gTlg5gg5RJVRgZHSc1fGPacLTOp/TM9js6a7mbeKr/XsuhZ0D73huP+w4ClKV+odNOB5rABB0m2Xb0GTKQihT92eppSb3BoKuEGWK8WFbl28sXAeo0hOgfg605c7gH4DGKCzzWd1htw2l0YLp5dtYpBywBnM66c44hU9U+3kxfNKAZ1g3WnUh3Ab2vvXi65qrZ81q/z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIvW69b+qwrHVzIZpAbDbDLhLDHPGaXm9Yz6wLPUgRc=;
 b=Frp/N0ZfUgPxPLlS4G85o4Fg04b+ZnzC/bPoPQPq0avFubE91CoJp4Ds0NzlDvplxL8yLaZAlmzrOEaL36Lp6eXuyW8CMh1DuGyGix2RDa6LIvj2T/6bJvbfe6Gl+jCEP8j1S6VI1eV4e00ZD6102dPikdUG70AUPRRoBtgWCCXNsHzuUjxT/rndwPEu7Qr3v4gyfasHEUzy7roUe//n7bYeo/Fo4uQ3+L4QyZRkSWYlJmG9whkGjDqd56V1RCoMlbpP99siHD6WfJuIapp/4Prqevs3PB2bv5YqmLYZn931XDE/CFv7oAEb0vGeg3VsO72R6vXulzQMKDVlhB1E9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIvW69b+qwrHVzIZpAbDbDLhLDHPGaXm9Yz6wLPUgRc=;
 b=E+0C7rjD2nlx5iH16OgNhSzEyYfV4eOM0hjF3GpZsIvWnnAa04OfU/Uj1ertcYnStANuOtYA0HhUyfzFRoQyLUvjDYDfopGBOPVoezzOVHOc3dWiw+Z5PPv4leEUNUeYAiDFXDXOYe/bfueNt3ghnFyK0l6+xNZZLUJ0PlnfCRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:05:29 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:05:28 +0000
Message-ID: <e246ba0b-e0c3-39b1-8583-39759c71fec4@amd.com>
Date: Mon, 6 Jun 2022 10:04:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/6] drm/amd/display: Remove duplicated macro
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-2-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220603185042.3408844-2-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 743cb08f-6f73-479e-4ea3-08da47c59c63
X-MS-TrafficTypeDiagnostic: DS0PR12MB6392:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB6392B3010142E8C1F322C2D38CA29@DS0PR12MB6392.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WR3JgE0Bntv68lDjkOx9EXvMV6xYVlJnOk7Bh940kD65H+c/XDd15pER1sZOZ2K1GJdEWZ1mWO9/S90vVq5Xpqt7sLY1wJpJpYwonOCuiiE5YnvpRjDNE3muVFvsjKCoYQ4ZbzmcnFlLfS+/IDOIG22s+4juPhDvj6AyMA0Q1M1U65s2/HPG61pTPCgPX+mQiWyDZ06cDXruyMUZq6LTfzBKue8OBtM58jsHPK4vBFfr8f+kBML8lMoPO6CrbqGrvyEA6MqbabJrF5A70ETF/Ou9/ILskihMsf4iXDJ8YYe+CKrKYTWSAlyaDw7S8aTNk3kO/Hipn1k1D8YDiVuvAhGCsjHeXl4NGUssin7avErMsrD7jDjqNJ6A3gsNSIxjbaFiCzYgzYOXlhh2i45shHSaOZaMHEF5u5rj0G5tSu3jYH18rEU2Jy9C7DkAJPX3nPTzY53C98xbR4wbCKW+A0VC9s9hl6esJFHEqIIPMfjjnyMa3MuXV4/UbH8FFliVyxbwAbpXDwhMbeufziZMICTtyHDf5JQ1ncaGia01ZdGz8NXH29pY2R9zudvddD2jqdqw9PERNnAmxD93iDCyxyDXHM3IMdzKy0SdODOewwAHWdCPnwFn52bf2xMmeBVPDrhhMlVJYJSjaDzBE+1bAmH4sowoXYjdquL8HZUAqkQ5HP2ASIGQPfCequLDhKz1RwnV5QLCpmkc/1epIxLJKsiKpzr1dosAKUpmz3EqIaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(26005)(6666004)(2906002)(38100700002)(53546011)(44832011)(36756003)(316002)(6512007)(86362001)(83380400001)(31696002)(66946007)(2616005)(4326008)(8676002)(66476007)(6486002)(31686004)(5660300002)(66556008)(186003)(508600001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHVWKzlrRURzb1lldUJVNGdETk94ZHQ1UDNBVGo0YUZUOVpzaUR1RDBmWDhG?=
 =?utf-8?B?SmE2WTBvV0hxbXJyeVdibFk0cHA4c0lFTndLSGZLRXRiZ1JFZUFlK0ROaWxD?=
 =?utf-8?B?NGNRaDJyVlJFUS90YURUN1JGcFZxUEFpQ05aM1ZLU1BlVTcxVXUwRk4zZDFv?=
 =?utf-8?B?ekw0TWNud0RKZWhpcmJKZnVMcWdTbnIvTjR2dExCMng0RHk1RjE1OEVNbTFM?=
 =?utf-8?B?MUZGVzk2Rk00OEpzcXNROElEVzlPWkZxdDZ6YWd1MHNtaFFyWW4yMGdBa3Rx?=
 =?utf-8?B?UFJaMm9NTWJSaW5lZGdaZGdPY2NjSEo2ejR4RG9Gc2xFZE1Xd2Z1dFFlL21J?=
 =?utf-8?B?ZzQyby92ckFCWXIxSXpGSmxpSHdGMDZXZyttL01pRWlPQ3JVdnNHQ0R0MDdx?=
 =?utf-8?B?VVQxS3Y1cWJXdFRFSncwcDZMN2hQbERCeUJ3aVpEU1ljTkp6RXJEM3VvRmhE?=
 =?utf-8?B?VUFYZmhZbGt1WWZVUWpqL2Y1blY2MWtocENNVTRWM09vUkh5M0FLdHZSSEZy?=
 =?utf-8?B?RGVDWTVTYmJZRXFUbFlyZ3JwVjd2c3phVjVnanRJYUtseTVrL1J6NHRhTS9x?=
 =?utf-8?B?bTg5NDdEcE5lRmFuMEQ3TjRyYlVsVHhTcVkvcTdSb29tQXZqQzZPekR6SEdV?=
 =?utf-8?B?eC95YXcxQXBHMjg4RVpvOUQyaFlIVHcxcWdyYWF3SXpRejdMYWdXbWFsT1px?=
 =?utf-8?B?M1NZYktWSGJCcmxMdUlCc3NZRDdyQ0VhaFR4TGowVEVPaGhFY05vbkNvQWlE?=
 =?utf-8?B?RkQwTTFMdHJCbGUrNDBPME84OHRtNUx2bi9qNFVLd3JOQUxBRThmc0xGZXFx?=
 =?utf-8?B?MExISG1jd3FjWEJBSDhubFBiMFhieGRYRlp0aVJQbzA2bDZnaXp1cFcyMEIr?=
 =?utf-8?B?Q2NHTW5NMkZkLzV6bzJBSGt6cDVTSFlYMmpnNGhoeXk0b2RiUVlUL1Zscy9P?=
 =?utf-8?B?SXJMWXhNMVRPTys3aHhXTkY0VTBEZ3NFdDY4dlZMSDlaRWtTaXd3amxBWElS?=
 =?utf-8?B?UTByTGZOam12eGVramRpdFRrUk9rWWVFUHQ4SEhTeGlGUXhwOWFmdE80SXRW?=
 =?utf-8?B?TjNmenByN0FQOEJvRVlpeDNIZm9HMlZ1MEQ0MzFvamVLRHNVelltR3lSNFNq?=
 =?utf-8?B?ZEhSZkRvL1NzZGJGL09tME9BK2IvWCtlVXFxcU4xRUVUQjM4bXNmaWUvdUgv?=
 =?utf-8?B?L0JqTkQvUDhMa01ScjVuek1Jc1RMZVljRnpiZW52ems5a1A0SlAyU3lEZ0Vw?=
 =?utf-8?B?V2lSOEJSamFmRzZqN2kxbG9TeEE1N1Zwc1UzN1hyWVZYdVhpMTVKdFF4dTIz?=
 =?utf-8?B?OE4vdFNjZjZ5c0FPN0d0cDVGbDNpcVdMTjdsRDEvK2R4Y2xZTDR1ZEZYSzlj?=
 =?utf-8?B?SDR4b3JMSW9oRGw5V2FmMllSa0FMTUNvRmNsem44U3F3RXZrRmtiOTBTYkc4?=
 =?utf-8?B?cmxRbnhkWURLUEVhOXViZk9ZVWk4UXpZdjFZY1ZCTktlaVZOK25FUEsrbDhB?=
 =?utf-8?B?aGJUa1kzTTdtV2pVUlgrUWRJMWtxNDJUc0VCVUgxdFVINnBHczBoaExBVHRW?=
 =?utf-8?B?bXB0UW4vY21pUE0rR25nVTFSVEJUTW5lcTN6bHgrejNqRDlENk1zRHhtdDJy?=
 =?utf-8?B?dVlUcVdxQ29mUzRObmxKTXlxRXVPUVJNWEJydThJVDUzSGE1M3ZodlhaUHpj?=
 =?utf-8?B?MUNtdFlwRVJhZHI2ZGhDOEVvQ0xlU0tQSlpkVkwxUkVCNkdzTmxZdWE0SGtm?=
 =?utf-8?B?SFRYWmRHQWpEc21KRGVlNkJWL1JaS2lKTjI3Tm01R2llTm1JVHJvaHVmR05L?=
 =?utf-8?B?VVFNQXpRa1NtRFcxZ2VjYWhFUDNETmc4bUFyTXA2QkJvUzhjV05NQ0RVdGQ2?=
 =?utf-8?B?UTJmdzVLVDM1VzVwNXUzcmk2bTJvZkpjbm9oMWlPWHNlY2Y5MzhUL3pQSVY2?=
 =?utf-8?B?dEZXYm1IeWhEOFRwMzdJL2FQRGJjR0xsdDUrRzdlSWFMb2VnL2NVaG1QOGtJ?=
 =?utf-8?B?LzdXVGt5MVVYQitFQlYrbFVGR0NJdXAvRnBoZ0hBSDJmTkJTNkVsRVQ1WVUx?=
 =?utf-8?B?cld2Tzhvdm5nOTVvelFxNDMzVmZTcm9xR3JxZTlBdHNuRmZFbGZyTnlMNVdL?=
 =?utf-8?B?bnMrbmZlVkR0ekNaSEVZOEdtcFFGUitIazlEQURjWXNtdHJFOEE4cFdQVTdy?=
 =?utf-8?B?VHEzZXZGUGx4VkIwakliUG1hVlc0RVU2TisrV3A1RU9kVlBXMGlMRVVHNlVY?=
 =?utf-8?B?aHhkTWN6b1owa00ybzR5ZUdad0k4L3RKMUl5dGlIdjJRTUtFaWE0eElyZFhK?=
 =?utf-8?B?ZWo5UkVvNlBMMXN3QW5jRVRFNHRrN04zZUhmcVEwNDMxazlNOVU0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743cb08f-6f73-479e-4ea3-08da47c59c63
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:05:28.7510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7j9kxJkUq1nslva/xKUwuqPvAfs5nIeKAZpVwyKTiTQuG7FhQai5pLdRUAz95oTorXyOFn5mqC1hM4Ix9JnB5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-03 14:50, Rodrigo Siqueira wrote:
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index 11391eead954..a0dffe30b394 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -221,10 +221,6 @@ enum {
>  #ifndef ASICREV_IS_VANGOGH
>  #define ASICREV_IS_VANGOGH(eChipRev) ((eChipRev >= VANGOGH_A0) && (eChipRev < VANGOGH_UNKNOWN))
>  #endif
> -#define GREEN_SARDINE_A0 0xA1
> -#ifndef ASICREV_IS_GREEN_SARDINE
> -#define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
> -#endif
>  
>  #define FAMILY_YELLOW_CARP                     146
>  #define YELLOW_CARP_A0 0x01
> @@ -288,6 +284,4 @@ enum {
>  
>  #define	FAMILY_UNKNOWN 0xFF
>  
> -
> -
>  #endif /* __DAL_ASIC_ID_H__ */

