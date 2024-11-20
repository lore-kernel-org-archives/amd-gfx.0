Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8674BD63935
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 12:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC8E10E3C5;
	Wed, 20 Nov 2024 12:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IlxTFgZZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF92710E3C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 12:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu0/psw7a4BfyGgS8i+aRd+Nt/x9/YLIGJlTy+n7BnOYtb1pU4EG+nbrcu3My1IZuja7XqETQrpz2QQKPlHkGCTW8D/KrAzRJOTm1cH9Jme6/On5PCFDSiZwz0iKHuY5afWxC3BGy+1ZnGpi2M1BF2+/czidaHQREGC0tY2j15oEt2Ug2BcZrRgFSeFFakRSV+uHk35JWVoIMJ27HBC+6sXw5r5B3bvCl+07Yh0ZTuK6WKd0qwdA6UzrKKckczWesVzf00Z8GdTtmB/M3d96h5r+/6G42mcEpW5598ZyMNYepehM/apSpR3++kGRM1/2u1lFLfVMn7qP2CdbU8HOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hna9n1csjPekpMnkPNXkiywFA80a5iML2oihmQhBGwI=;
 b=X1VwMOow3YJ7aZgZfOznNn/fy6gRClxZHgHiTyo/aHsOvUn+0GCaENM8s4pXxzozx3YmCeBYfFuP+7zqScSsxx23py1BGrmfEjtAlCFofPg6GPVFqnkVGCOeJ3p1XOLCxRetDRDq6jRU2c9+WNAPRssawHElzcL4rJsGOwts1oSDpVHDBi/QaxoXLFk9pkHGtyjwH/73uIcBpy+GZMd0ervw7UVFN1CmXrR5fg3VXzDkzqpfxHfZ07z1QDXecxAoF8ESGd7jwQovQSB4oLW2fIO0V6zApInrRhzftBnb52BiNhQOXpDZYVjbZrh9vWo5jbmvJHWsBZAGSSaCFZ36CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hna9n1csjPekpMnkPNXkiywFA80a5iML2oihmQhBGwI=;
 b=IlxTFgZZbNjoOZXxjkxch50i+K9RmLaUM95/8yov8NgZFU3covCNSM6mZwHyqhjrAHYg1QyeQ9s1aFXv9oVOS4FrIANjBIdCycQjlB4p44h2WbHJQkbQmagN1oWcixdM6jtVd/s5BJVi/+jcj0tOY2GUWpsGGgvDJ0nLecUdXsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 12:48:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 12:48:34 +0000
Message-ID: <9946972d-5ab4-4e4d-ad18-20bc1a406407@amd.com>
Date: Wed, 20 Nov 2024 13:48:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: reset fw_shared when VCPU buffers
 corrupted on vcn v4.0.3
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, leo.liu@amd.com, hawking.zhang@amd.com
Cc: david.wu3@amd.com
References: <20241118094737.1024533-1-xiang.liu@amd.com>
 <20241120123432.1075304-1-xiang.liu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241120123432.1075304-1-xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e7d9e8-e106-4324-78db-08dd0961a53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUlINnNYenRJbCtqV1pCZUtNTUF1RzFxR3lXU25hL2FDNWhwTVEyRjhJakhY?=
 =?utf-8?B?WTR0TCsyMGcwdXpMbjROVEU0bmFVZmc2QSthVDE4UjRPd1I5TVl4RmRKUDNC?=
 =?utf-8?B?K1RtYUU4cGRwMlg3dHdZQ1h0eksvR0ZBTTduQ1lmSHB4bk04eEQzbHUrUG5E?=
 =?utf-8?B?Q3Rvd2l2QWpiVjhvditCWGp0QUlaRnZrUFFNbkJ0bzczVUpWNEVnL0ZxSmsx?=
 =?utf-8?B?S3VaYnlUZVIxemoyWkV3NkhaMDBZL3RzdnljUUpIVG45NU5DUVZmcno5cTdS?=
 =?utf-8?B?enhsWFVjSlcvQThSdjZRb3NKMDVWVXdlR3lMTmlBK0E3MDY4TkdSWlZTWmow?=
 =?utf-8?B?cWMrZElEOEVqVVQ0TEVnVEhlUTdwZlN0MS94RjhvM0o0VGN0eHYvOFl3VUxa?=
 =?utf-8?B?cy93SDZDdmFJZmwzc0pqSHB0WW5TYmcvRzlSWkxCUDUvZzRVZUkyM3BnTnYv?=
 =?utf-8?B?S0laaTBXWWFKOFF6Y0EyYjJpNHIyNWMyaDZnZy9nNUh3MmhGc2FGa01pZzBv?=
 =?utf-8?B?NGQyWnZzVGVUUzRHNm4vNm1rM2hGOUc3ZGVKUEFvb20rRjM5aUZ4aWovUHpF?=
 =?utf-8?B?NjB5K2ppbllWZG1IK2NycjFKVlhLTG00MEdRTEhxOU9YUnF6akpQOUJjTldl?=
 =?utf-8?B?WFdPYWtXUjVWVUprd0d3STZyaDFaV1lxWkhIdnNhUHI4ZFg2TFJvYzQ3dWRV?=
 =?utf-8?B?QllsN2hoeFJ0RExUckpQUlQvOG1tNzdkcXU0WkZ1VnFZNVFXUDdkT3hDTkFD?=
 =?utf-8?B?M21Kc090QWdLWkQyTVlZbzRZa2pGRlZ6TXlGMForVlBocTh5V0FERStZd1A2?=
 =?utf-8?B?aDF0THJPZU5PQjBYa2NvWXJLZ29rM25GTDN4Z2ZrVDQyZ3Q0c0hNNHVnd3Jv?=
 =?utf-8?B?a2h1bjRrQnJOZ2NkcEF4QnVqQkhZUTQzSWUwRzlXNkxRMG9wTlBicVFhQ3FS?=
 =?utf-8?B?bHkrb2M4dVpGdk9QRFB0NDMybUdlandUbnNDTHJ1T3kvc3Yxc0tWd0FhVzNq?=
 =?utf-8?B?a0U4OFdQRnNVOFZuVm8rdXd0cE43MG5VWlhHTncyQTN4V2hkcGQ0Sms3d1NS?=
 =?utf-8?B?anE5amRwcFFmREJrWTd2anlVMzRTeWEzZGhRQ080ZXlKNG9sSHZPWFJabmg3?=
 =?utf-8?B?LzlkY2NYWGdnZGdzRkJtTDVPSHpiNFJqNVpTUXlLem9hMGNiREJxb09TTGxv?=
 =?utf-8?B?dTNoWVZsek9mZmV5TlpDOUpaR1RXeHhGSytsT3p3bk5HL2VrYTU4Y1gyTFRv?=
 =?utf-8?B?YjF2dWw3S1h0NGhhQUFTeFRaTy9uTU5oWGdYYlVHOGh4N2wrODZ2TUM3MkNU?=
 =?utf-8?B?SlI0UW1yaEQxa2FTSm51anhrTVhTRlo5WG9qZ0IrdTFkQkR4NURyYW9YYkgv?=
 =?utf-8?B?OG40WFlYQUV0UGFyOVlrV2s4TTBEcVc5QnIxVTBueTlOVVNaOUxHWjdWdTQy?=
 =?utf-8?B?RXg0UkZ2aHJqU0U0QnRKWU5zNzRUVktLZEFzUVF0NUUwcWQ0T0crTVpSaDFD?=
 =?utf-8?B?S1FSaE9WYmEvOGtDL1ZjdjB2eU9SbGJUay9JWWJyVW1McFdLaDB3a1BQYW1M?=
 =?utf-8?B?TCtjVElVbGx2OCs1SmIxdjVOYUxsak4yK2k4MEFXS1dkcjlWU0JNTlIvQTJP?=
 =?utf-8?B?L1BoWUZjYVlZVTVwVWNwV3RuT1VUV2ZSc3d4ejhqMjJEN3RQc1BKT2x2bUJH?=
 =?utf-8?B?Z3MvT2tSU2lRSTREWGpEeHU0QXI4SEJSRWY3WmhsMVlpVVZqZUtHMExJcU5s?=
 =?utf-8?Q?FTW3z/Cq/VT2m05Dvc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTc2TVg0bFBuQ1NRWUt3dGNzZDZXSlpWbGhiN21FUzBiVjJBREpXekVPemlo?=
 =?utf-8?B?eXhuSFA2VFlMb09JdGFuem0xbmM4UFZlRWkxTGRQdk01NjM3MUpwS3hOS2l5?=
 =?utf-8?B?dWZFM3hIOWFqSGpBYzhveVNLMEFaRFB0c2UrbmdJSGwzczRrSElnVHFRakhm?=
 =?utf-8?B?WDRjd1hGLzFIZ29yUGZBeUMxY3FrKzRGTVJhSVV1N0JmSnVEcjUwcmZLdXJw?=
 =?utf-8?B?Yi96dHJLNVlPeE5PTnNjMEMxUTh4YkZtZ1J2dUJmQk9GdWJReFpBSjhCTlFw?=
 =?utf-8?B?L1VFQ005VlhhN3QvVU5tekIybE5Ha2Y0U0xUSmdXZS8zckhLVVZoV1FkaDNz?=
 =?utf-8?B?MzBpSzZ1VW4vN1lOUTdPNlJLYmFPSEVDTnZWVEMxazhLM0Vic0M2dnlhOGJ3?=
 =?utf-8?B?cDRBUVA1V2RleUlvekNWbUx1cEJScHMwejhWTGw3Y1hpbDVNQ0FFMjdzczJV?=
 =?utf-8?B?ZmpPRUZ3czcrOGdBd0JzUTcwSkxQelBYV0JZT0pydzN0ZlJOZW5kOWlMSmpZ?=
 =?utf-8?B?RmxJRXRUQ25HZElDdCsrOXp5NlZMVTNobFNaZTJTZEkzVUpna21QbGdPclVF?=
 =?utf-8?B?WXUvYXBpdXJ4UExuOTN1UFA5T1BjUWoyTWJHYW83NnZTTEtBdWJUV2s2SDVk?=
 =?utf-8?B?NzVvenB4UG1pMEJhUVNNZGhacHVPZEFsUURXdjNmOUZtcXoyK3F1SEhzb0JD?=
 =?utf-8?B?YjVBRGJnenZLMEdEbWxxRzFqYUdpSTJTbG44TU81MFJjRFZrdUdHeFlEUDlD?=
 =?utf-8?B?T1lmMndmMmhiTzErUXZja1pDaHA1ZmlKVmVZTUlvajN2cy9hUVBRMDVOZUM3?=
 =?utf-8?B?UEI4SVpJQ0NZM3NLMWloQUJHNTgrcTZBTStxMEJMZmZLQ3FJWU5tNFU1dUR5?=
 =?utf-8?B?SndUQmdWdlJGakdyRElYdTRWODRRd2dQVW5UWnRNelZMREVnenNHVzdPbTho?=
 =?utf-8?B?TmdKaXR5ZUFYTG5xa2ROVGlxT1M1MTRHaEVqd05wbzRlb2paYzdmKy8zbUVJ?=
 =?utf-8?B?elFLMHZWT0o1eGFUNi9SZ2s4Wi9qN09VY1E2eC9abjNqTUs1ejhGNGxWNUdn?=
 =?utf-8?B?QVdtdzE4MDFnVkR4RXUvVXpxZDBkd01DQWJ4bkxLejVOUVo5eDhlVFJ6OVhQ?=
 =?utf-8?B?bzhGTmhIcElIc29EN0c2dncyYW5sSzJrZXVud2gydllXWEY2WHBLVW54c2xh?=
 =?utf-8?B?WGxrWjRkVXNFYmtwcjZRT3JVSXNBMGZQSzFSeWN2cGt4ZWVIOFFDaEJiUWJJ?=
 =?utf-8?B?N090ZFhpUjBxcndGRCt3N2UrVnJKdnFBWDQybUtUNEgwQXZXZUtHOVBmdkJo?=
 =?utf-8?B?L1Q2cm5JdFZJMVBqa3cwQkJUbXlFeUFpQUFDY3JVaGtKMVU4M291Y0VUZ285?=
 =?utf-8?B?Qm01N0xnOVVvOTJsZWpZQmMwWGtKZC8yOTJxM21oSktsNHBmWlFLcmFaU1gx?=
 =?utf-8?B?dFNmblRmcVAvUks5THBmSit4TWhoOE5rUTBDNitwYmNrR1RmUVJUd0dLOE11?=
 =?utf-8?B?ZFp4Y284dXpSdkxHTlNUQWRMdUEyd2xTWktsSE13OE5abExSUEJoMlNFRXNV?=
 =?utf-8?B?MnVubkpnaGxUQUNUNWxZNURsNS9QZ1VvK3NXRVpmSTVQRDhkS1UwMEFXWmlF?=
 =?utf-8?B?TVJyZUxvVk1IN3ZMN1RFaDRIbnRSdEZVcU9URTkwcU9NVGphQUNHdjE5WlBl?=
 =?utf-8?B?RnRYdi9mSG9wM3ZkaCtTUlpsT1B3S1FsSUwxNnFGZjQ5UnliaVZrcEF1cFRr?=
 =?utf-8?B?UVZBb3V2dlVuVnlHM2dMVXFmbFh0UnlRWU5zMzZ5SzR4c0o2eUJYajlWcjZm?=
 =?utf-8?B?QmVSK0txY0I1WEd6MGpMeWlUV294K3N0emhwM1paVVRTakROZS94eUpURHBK?=
 =?utf-8?B?ZjZOT2YvUDZIN1lZaklQcFpvWERvbE1UaG9md2U0a3RJblRQY2NZUlpKUnJM?=
 =?utf-8?B?YVIwTGtqdmdlN1Y0M09XVXZ2RHl6N3diUENvY2ZLZncyWnJWazBzaFFzQTBa?=
 =?utf-8?B?bDJRTzhSeG9WR0daVDZrbmVlUDZYRDZSMmU1eDIyenJBRERrYlNSTG1BR0Zp?=
 =?utf-8?B?YXhaMFRnb0NsQmhlaDR5ZTVpUGU0VG4wd1Y3YkhMc0cxWTArY2xLdW5GbWpa?=
 =?utf-8?Q?7UFQSrJlA/PVg6vFmAsuSrP5y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e7d9e8-e106-4324-78db-08dd0961a53a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 12:48:34.7387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoZDHhFzZ0JqEgL57gxsChRWSe/e5sr9vhtUsDqOn10tChbS0xl7F9PoHrb8pTbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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

Am 20.11.24 um 13:34 schrieb Xiang Liu:
> It is not necessarily corrupted. When there is RAS fatal error, device
> memory access is blocked. Hence vcpu bo cannot be saved to system memory
> as in a regular suspend sequence before going for reset. In other full
> device reset cases, that gets saved and restored during resume.
>
> v2: Remove redundant code like vcn_v4_0 did
> v2: Refine commit message
> v3: Drop the volatile
> v3: Refine commit message
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 30 ++++++++++++++++++-------
>   1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index d011e4678ca1..c678631c6887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -123,6 +123,20 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   	return amdgpu_vcn_early_init(adev);
>   }
>   
> +static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
> +{
> +	struct amdgpu_vcn4_fw_shared *fw_shared;
> +
> +	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
> +	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> +	fw_shared->sq.is_enabled = 1;
> +
> +	if (amdgpu_vcnfw_log)
> +		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
> +
> +	return 0;
> +}
> +
>   /**
>    * vcn_v4_0_3_sw_init - sw init for VCN block
>    *
> @@ -155,8 +169,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -
>   		vcn_inst = GET_INST(VCN, i);
>   
>   		ring = &adev->vcn.inst[i].ring_enc[0];
> @@ -179,12 +191,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (r)
>   			return r;
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -		fw_shared->sq.is_enabled = true;
> -
> -		if (amdgpu_vcnfw_log)
> -			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +		vcn_v4_0_3_fw_shared_init(adev, i);
>   	}
>   
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -280,6 +287,8 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   		}
>   	} else {
>   		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			struct amdgpu_vcn4_fw_shared *fw_shared;
> +
>   			vcn_inst = GET_INST(VCN, i);
>   			ring = &adev->vcn.inst[i].ring_enc[0];
>   
> @@ -303,6 +312,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   					regVCN_RB1_DB_CTRL);
>   			}
>   
> +			/* Re-init fw_shared when RAS fatal error occurred */
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			if (!fw_shared->sq.is_enabled)
> +				vcn_v4_0_3_fw_shared_init(adev, i);
> +
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
>   				return r;

