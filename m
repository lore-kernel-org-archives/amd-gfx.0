Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A48FC5AE59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 09:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3385710E814;
	Thu,  5 Jun 2025 09:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kByn5F+P";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C96910E814
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 09:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpZ8qx1moJCRWgNSL9ozVFSriaMq1uASjWMXDjczkgE3t1DVLu/Mw+ek9wiMbxoHuKpIRx/Ttq12qPURDxtZykrmQUM5wEIlZzNEAzvRvRGlGZxJgTlnUUhIf+WravLvSERKvFa7mad0to5KQ7lr4iTNcH0sO/zlr9XMCYI4PLfNi6/S2rhcaodb36+W4r8GpKqxQfuNdo0xn8488ydkYf0bTO1eQ6yep5x6/PrFIY9jz8b+Feu2WElR/dhsN+50j7nUS0iTAAzHgnTF0XJgfFZGb6pQo9hk0GrDG+W3Du7/0S31WxRen3Ve/gYf2VhQ87y+IPqO2siiHItzom/0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vBAjOz0r4agPdfUE9wWy1Eb6FNSuVV4liZ+VrnGk/g=;
 b=Di7+hcQgsZfwjR0AQ0fEBaslxl0JmQPUkhSddO51tPLNJ1VYZBCLFsLyiX//8HVtAM9vKbORcj4hSvcdf7mIksec3EWP2KXsIVGgJmnSWKdyGnmGI/OJRjqkCJPkjg31KgfqiZXJA9Lag9xi9RJZpz28j8L9DEB/P4G01tJ6nT1Fo5vHsgAtXndfVDfN6xSZQXnBCeL3n2iajPj2+fs/5uDTELn+kIXc00finSSykMtgVYtfpTLyvx48pctPsZXnYFhO9GxFhoAp3RCUvGvzRO3n/eiN1Q3OtdFmegwj+bgIhME1nCYIPCBtaGfODuh6xKUr9mQA63AyDxTQ3hY3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vBAjOz0r4agPdfUE9wWy1Eb6FNSuVV4liZ+VrnGk/g=;
 b=kByn5F+PZOt6/yO51c7l5ymMMxcW/BpBCadk7b4DpBqiXuFtZvcbEL23wwMJe2kv6IXVngrfk9dVxm3uPZEc/D2wDzQYqtA21Tru8pMik5rGI41QJ1ySl60Ot9EbiFdi6HWJly/R2j61pQ8N1JHfWlmjPVpiRaQIcmFhY3nCyhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 5 Jun
 2025 09:54:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Thu, 5 Jun 2025
 09:54:14 +0000
Message-ID: <f41b8aff-03ed-4a6e-bb91-134c11357bdc@amd.com>
Date: Thu, 5 Jun 2025 11:54:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <450fa7e8-5d91-46e8-8b01-1195fe437a7a@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <450fa7e8-5d91-46e8-8b01-1195fe437a7a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:530::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dd4036-e9a1-4b40-a338-08dda416ed83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejNMNFBkclJYNEpWc3RIVlNvR1o2VWIybXJnZjFWakREWCtkdFp4S0Rpb285?=
 =?utf-8?B?K2QzVEZjazNCYVZOa0Z4clV4bkNHMEs2dFRqK01Pdk5wWHJwYldXNnVpU281?=
 =?utf-8?B?NTBwTkRCWUtZNk56bEE3TFFLVVcyQUZNYXByYmxRSXVBSzMrQVQ2MXFuQUk1?=
 =?utf-8?B?dlR4ZVZCQ0ErcExwZjVYWk9QdmR4L1RtdDZyWWhpUERxOSs1a2RmZHY4ZUJM?=
 =?utf-8?B?UFRYVEpyNXJ1Q1lRd2p1cmxDaWZ6VTdkLy9mNHFFeEdDQ25vYVpzcU55MjhB?=
 =?utf-8?B?Ly9hZjRwcVgwVk9FNFhOY3hnT1Z6Zk5uNHFlcWIzNm9lRnE0L3RvZUkrcElE?=
 =?utf-8?B?UGtpV3ppVEd5S2xjUndyUDYwOWl2dW9xODJzaXVVSmVJYS92eUY2U2ZTUm45?=
 =?utf-8?B?dDhvRUVQNU8vV05yUlJid0JjTVR3eDNtcFpLZW9Nci95Yk96a0tqbnhlK1RD?=
 =?utf-8?B?d1RBV0RTK0VXSVljekI5R2lSc1FvYmJraGZTZmJxVnVZcTYwNE1vQVRaSmdY?=
 =?utf-8?B?ZzJQMzJuRTNGZkhlZnc0QlVGR3pNMXVzbVlZdDVGNDNIMzBoVEdtVmNIbmRD?=
 =?utf-8?B?V3gwRHc4U2J5cnJNNXNKZC90UmxPc3VtN09Sa0hnUUc5SEFRVEg1Y3ZFRGpX?=
 =?utf-8?B?VWRnVXV1WUszb2dNbXpSRTB5cnVTMXNtdVZIWGZYejdaMWtZRmF2NHFIUDQ2?=
 =?utf-8?B?V1JRRFdzNllIU3BTcnoyTEpBZk1ZRFZTS0crSW4wVURTS3NXRVZORXl4ai9J?=
 =?utf-8?B?K3Nvdzd1SUthOXZMWjRibGZ4WGdHZGhScDZtbS9rb2ZaUmJxWW54elRsU2Jn?=
 =?utf-8?B?NDlCajZ2c1BuTzNLZTNLcjZ5aUk5ckRPMUhGeGlRa0U2V1UxU3MrYWdPeExJ?=
 =?utf-8?B?ZFNiRmw2K2FkMnYxeS9uMlE5Z2VQMVdPalVnU3R1R1FvTk45Mk5FaTNwTmNt?=
 =?utf-8?B?TnBtSWxNWU1QMElXVENSQk96cWloOWZ5am9nZ0M5elBlS2MrbUhEK3orYWtC?=
 =?utf-8?B?WFBiWkN5TVV5T2Zic3d2YWs4d21WQ3lYZ1BsWjVqWUszUk9TSEh6M1ZJSEVy?=
 =?utf-8?B?M1IxMnVRcDlIYkErVHFxNmtVRGhLeXRtVGVNU1VKZmtKZDhiS3pFaEh4TkVp?=
 =?utf-8?B?YW1jMGY4VHh5ZzhocG5zR3g2aXI4a005SVJ2RmtQdWsrNXBxR2FTcXRPdVB5?=
 =?utf-8?B?aWhoQ1hmcHl6REZlR25FTVczSTc3L2dUZkUxOEpXQjZzWU5EWVlqcXlMTlhY?=
 =?utf-8?B?TVR2Nm1TNjFjcC80OHI5NmptR1VGZlJsVmxLNnhSTUdRU3JHS3lnVzByNG9X?=
 =?utf-8?B?Q3JPQlNBZExqMG9HL1Rmci9hTitQS3dMNTdkUjBDbXlRLzZxdTROS1FTYUVV?=
 =?utf-8?B?M0U0N05rYmprQ3kzY1RGY3NISlBUNCt1QVk3Wk1XdURiQjNrY1JOU25Cd1Jm?=
 =?utf-8?B?aDdkKzk1MHNRdzdpZGlmTVV4REt4QXJzdnBsTDBscFlQZ0FZNVhWazdzZmxp?=
 =?utf-8?B?RTFaOThoWFJQQ1MwcEplL0FodmszR1VBM2xjYTNkRFFaWFRWZ3FKL0ozR3px?=
 =?utf-8?B?OVFJc3ZjdGpEcGZCVWkwaHFVU2pGZlRCY2xESW5ncmNodXRMN2pDZ2o0NXNm?=
 =?utf-8?B?OEh5MXJVajBMRTNkYUFDRWh1UWNyMWxwMkRmZ3JIK2MzN0FZOGRmYmhjYjZS?=
 =?utf-8?B?TG9rZlF0QVFCeUl3Vi9kbFlSKzlrTjltTzJEUzJIMWx3akxvdjVNbm5DL2Ey?=
 =?utf-8?B?NkgzdVZhYkdyNUwvTDVYMi9FM294UmdVdjZ1TzdsZHI2NFF3WXZ0a2JXTWNj?=
 =?utf-8?B?WkNFTmpPRElsYjM1UXVRbmNVdm41V0gzanZpc1Vmc2NJQlRNeFVDTTdLTWZX?=
 =?utf-8?B?dFlrNEg5OEtUT283TUMydlVrczRDS3R0Zjhnd24wVzRPdFMyUVJlMENESm95?=
 =?utf-8?Q?57ar5mIik4o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHI0Vkp5L0FtYVJjeWhzdm1iR05wOTh2eWh6YjYvVGdsclNMTFpkNW4wK3FL?=
 =?utf-8?B?clM4N2hDVHZQd1p5Zm5tNlpGdmZuVXA2aUxGWkZ1Umc2WktBRjFsMGlaU2l6?=
 =?utf-8?B?N2NjQ0JLS0d3U3NndGgvZjM4dE9lYUVTc2xvUDZpeG5WWWMrUTlVeFJVaVhH?=
 =?utf-8?B?eDJpRkVLc3NCbXhxNXdkNUtMMTNGN1JCb1kzQUZwbFhiSlU3bDY3NVY1Y1JQ?=
 =?utf-8?B?QkEwMXA1ZDltTHQ1eXVQaHFUMS9GUHJSUjN5KzgydWlWMnJrOVN3N2dSYnZu?=
 =?utf-8?B?UU9paWdFRzZHRjZhcFJaUDNMclRTa3BlOERXbkhmVFVjbzNuT01iU01DV2I1?=
 =?utf-8?B?ZVhNb1FkcUoxOWlqaVhCaG8zRlc5ZWVvaDhvU1lQdW9KejMyV2ZPYVFMbkNy?=
 =?utf-8?B?MDdlcjd0dUc3MDJLQU5Vc3pCNE9VdmhvUFUrVTVPU3B2b0lBVmF0ZS9mNHRU?=
 =?utf-8?B?WUhUdTcrVU5MYURIWlltaDlpQ210akJyOW5NMWxpb0N4L3Q3dnRYY3MrOGRy?=
 =?utf-8?B?WG53b250MDVLQU1pM0VuTnVDamF3elJnYzJOVEF5RmFhNHFkeWdWclpMdks2?=
 =?utf-8?B?UzBlblJCV0RCMVFLTVRQcHBLSWZlaFhjcVpRbitMREZ5a2E3bDgvTy8wOXZF?=
 =?utf-8?B?M3hZVlQ4em8rYS9SZGtKYVVnSWNDd2ZwS1NhNjJ2WnZlK1BOMVBocXA1dGw4?=
 =?utf-8?B?eTR2MWxYU0dZNy8rTEZjUTNFZ0lJN0RxSmlBQnJvQ0pRblJ3R2wrMFhMZDFI?=
 =?utf-8?B?SEVxL1Y2SmMxV1pFZktCem9FRllsOWZZYUZSaUl0c3FlRDlnL2ZZTDNJdkYw?=
 =?utf-8?B?N09NYnFUdUpOQ1I4Slg3bk44d09GR1M3SldITGMzdVdia1FEK0FzT09qVTdV?=
 =?utf-8?B?WC9qeUQzbUVEZ0hGd0M2NG5zMnA0QmdqaExESzlOMnpSbGxSN0xjcGRpYld3?=
 =?utf-8?B?RTBtdGRIbUMwejJkc0hiK09rZmNvUVVZanQzNlI3MHg0WUwyZ3pQT2RYY1ZP?=
 =?utf-8?B?c20ybWxYWk43TVlmTUJJaWQ0TDl1aGhOWXFZQUVPMHQwK1pDZ0dRcEo5bVI2?=
 =?utf-8?B?YVV5eUlkQmhBSFZCTDEyaUVqS21SNVhNeFA3Y2hseUVjZEZSYnVCc3FYYzcy?=
 =?utf-8?B?eFVneVNIeE9CMnNwUUhSL3RKZGZ2UDNSLzk5ZnZ1N094cEF2UGRUVjY2VVpn?=
 =?utf-8?B?b0Z2TTB5T1B1TDhOQ2tQQ3JWVFkyb2l0SkNZR2R3anlLY3RXUEVBcnpVd2Nq?=
 =?utf-8?B?VlBzMmt4eEQ0c0xqaWU5TGw5eGpmeHpadXFNazdEN2tmNDcxWit3bjZjd0s3?=
 =?utf-8?B?WHpsemR6WE9uYzlIQXo5UUlzMDh5d3FuVmNLQ0lwSWdNc1RIZktkV2ZzVkJu?=
 =?utf-8?B?WlBOT2x2YzVBVERUTzBQMU1aZnYvc1BkUlBDYnNpSEZZRmRNTmk1K1ZvaEFB?=
 =?utf-8?B?MzFDZmdVQUlCd2ViK1MwcmxGanM5c3VGeFJuY1l3QjcrRlY5RzMxUVVEMHpw?=
 =?utf-8?B?OWhyZGFRdk5mb043NkNvU2tzbndMVUF5NEVodGIyQzJORXA1ckp2YzFPd3Ur?=
 =?utf-8?B?SWRmZnFoWDVGOXErNWY3MDdqVEpMRm0wQzBoOEVucmIvMDBFN1Q1Sjl1dTNY?=
 =?utf-8?B?U0N6VTlRUWJ1VHVWTE5RbGtwWTJDYTIwM0l3M0dONFdiN3J4QXgwSThMUU1G?=
 =?utf-8?B?Sm13TXVPaDRieWxsNjJJbS95LzV2WHVGNEY0dUxJaEgvdUlYbG9zR013NVhU?=
 =?utf-8?B?WkRNWnpwNDU2RFVHak5vOEVJcjJuSEllUkEvTDRsWGhRRmpodmpvUUdFc0Va?=
 =?utf-8?B?d2lLNFk1aFJMVUxvOHZscUNkSkVoY1d6dXpYWmZrK1QvdCsxc1lsQm1TN3Zz?=
 =?utf-8?B?b0VPYi8vUmcvMmpqeTZIdndzT3hNV3ZmaWNFK1FadlNYTjMyRWRlRnFZcWlO?=
 =?utf-8?B?eVF6TTg0Q1ppQ09EU29VRHpmS0VaM2thSDcwQy9rMW0yY0RHZG5DYXFrdFpG?=
 =?utf-8?B?d01LbGsyd3YxRmU1YVFYS3pXQjJ6VXpqY0VUN1NpVGV5UFppeHY4Rmp1L0Y4?=
 =?utf-8?B?TXlKR21GNFZaSkoxNTF3bktiZG1EUlJ2Q1ltUlc0Q1UzbngrS09STTB1My9J?=
 =?utf-8?Q?Q0D4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dd4036-e9a1-4b40-a338-08dda416ed83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:54:13.9742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwHvJt2OUDwPq0Satur8UKYJImdcpDR/hPH7oGXOP0tjy4wPG0DhdUc54aFlRJVO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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

On 6/5/25 11:21, John Olender wrote:
> On 5/2/25 4:36 AM, Christian König wrote:
>>> I think we can just make this VRAM only.  Or something like:
>>> adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM
>> Yeah completely agree. It's a good catch, but the solution is incorrect.
>>
>> On the older UVD MC interface the FW needs to be in VRAM or the validation fails. If it's inside the window for the message and fence is actually irrelevant.
>>
>> So something like AMDGPU_GEM_DOMAIN_VRAM | (adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : 0) would be correct I think.
>>
>>> If that fixes it, this should be tagged with:
>>> Fixes: 58ab2c08d708 ("drm/amdgpu: use VRAM|GTT for a bunch of kernel
>>> allocations")
>> And CC stable I think.
>>
>> Regards,
>> Christian.
>>
>>> Alex
> 
> The simplified patch needs this change to the vcpu bo domain.  Would you
> prefer this change as a separate patch?

Separate one please.

Just send it as the first one in a series.

Regards,
Christian.

> 
> Thanks,
> John

