Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4F0C25B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 19:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C26710F2A2;
	Thu, 30 May 2024 19:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMGyUiTj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A73210F2A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 19:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llnqNOL7XEI4pxHKKfP+uKnuyhrlIYM434gdExZRpy+Sc9SBkSlmXPla+kv3ckMxZoTjxGTV7GD5cYQLoWrU5UZhLXlxeMCYfloMeyYO/rFBxGpHskyuC/1pGlHxVZHfPXmWjtETVNZzI7LLRMqPWPiNFLceYyuyDRwGxk90E6ZjHSnERLJROI842sX/mO2OCkHT0WdhY5Sd+F9QNtnglCoGLenrvbleRSxGosC+AknYA7d/pb0ixZJtU0M6MnBhK/xHO0tojLfU3JblpDDOVRLQTj3gVRoQsfBs3NqFaBWhTkD/d8yVEnl4h9VExWDV7NFdCdwL9Knf6Co98llRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2tizqV4C8HD0uqVAQuWyl6No4lfNBrPjejn7rq9MXM=;
 b=i+AqZE2w1V6Gxu/WZlGQ/FRVEC7A69j60aRIwFaaZw3qRr/v4kf6YHYfrJoNZwVMIkB7hjnh44ooalmV+AeXVUJ6mlhJVTn0b07ZLI5fiKpACA430QehJetw54CKXL6ZJKHgoD2t/dWXWcBKtvlZbehhzTx0PVmkf4nLiskQ4S523LEuATDpVw77ewEvADMItG3UBdP+P4kbskSoVZCk3sNnWO/OyfAI5RuoaHYCy9EGRI7yzWBRMRrEFczai4OGQnhjpicdYsS6wcq4uuhGw/H7ikl6hQOPdHbLWYNRM92pb8S8ZcNqdkM7GJdi5RiOHI9bSM/FpcUDu/xlw9fahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2tizqV4C8HD0uqVAQuWyl6No4lfNBrPjejn7rq9MXM=;
 b=RMGyUiTj/kppdARes5ItJP/UC+FyQi9YBivNnPKCZD+vf9t/qjYjAMhv17OriOQ3fc/+0JOEpw9acLYAdddgIsLzWozMpH3sOQ0XDlfg850nt82figDH2ZtOqnpelAT2y84AiJZ7vBLJmZlZH8j6GND4SqjCt6GlAFzadOcCsX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 19:58:03 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4%7]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 19:58:02 +0000
Message-ID: <05859b28-e4ef-43f9-a540-7635dcd329f0@amd.com>
Date: Thu, 30 May 2024 15:57:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Convert some legacy DRM debug macros
 into appropriate categories
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240528125711.86488-1-tursulin@igalia.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240528125711.86488-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::8) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b11a05-0205-4296-c7de-08dc80e2d030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGhlSkQ2UXlBdHNNR3pZdU9ic3A5TEJzR0RPb0RUbGxFWnNDeTNXNWdKM0lr?=
 =?utf-8?B?WFVxRm5PTkhSTTdIT2Y4TTZ3SzFMeVljbVFDcy9PNkR0MCs2WFBvOGxCc2pZ?=
 =?utf-8?B?SzFJakxZRUpoYnZzRm5OVXd5NkJyeElad2dWMWZtM3FOcS8wTHlJMGVEN1BZ?=
 =?utf-8?B?OVVqdThPVEtCMEJoTHpXU2Vsd0tnYjR3QUNxeUpJc2IwM2lVM2piZEkxejZl?=
 =?utf-8?B?TXNKdzlWTVhFalk4THU2SXNiZHY4aXlxV1J5RHZWUzdCdHBQRGlNaExINTdt?=
 =?utf-8?B?VjBkK0RLTGRGM0FvTXg2WlE0RE5zcXNFVXFmRzRlaTUxbjBvcFlJdUgzUTg2?=
 =?utf-8?B?dXpsR2QybkVTWVptL2JPMFluNmlHU1BGTkFWcVI1Tk5TZlRSNXZORmYwMEhx?=
 =?utf-8?B?cVhVeDlEU0NQa01PcmFRdkJoYUdmMlRSMGdOT0VteGErV0ZtalZrMExZV1Mr?=
 =?utf-8?B?WENWSGNQV3h5TE0rcGV5T0c2blpvNDBUR2gwWVROY0kvY2RrbGFRSU9yZWpm?=
 =?utf-8?B?R1VDVkNHZW5Rb1pxaXhOUGhrNGNDOFdDaUlEUDQzeXNIOEpZQXpHc1NWVnBq?=
 =?utf-8?B?c2NvUVZVekV6WGxPdHFndVJhaDBCKzdHRHBZWEZlbytVYmFtTk1kS3FoZFpz?=
 =?utf-8?B?Rk5idGNabm1CZEp4NkhsV1pMRFNMMDZ1bSttdDN2cDFnay9wbFpNRFZ2dVZq?=
 =?utf-8?B?SWpSeGNPc1Fkeml3TzlKbWNLYVRqa1Bzc1doNDhNWUdwSHVrSitrK0N4aFBU?=
 =?utf-8?B?M0didmxTWTZKaEdIbndLWlk0WFBpeXcvT1paMXJLdm9KNGc1RisxcU4vVmNZ?=
 =?utf-8?B?RUVOU3RPTTBqTGpPenV2OUJxdUJtd0lsa1daeGhLR3QzZXVsRjRXenJzZm5C?=
 =?utf-8?B?Q2w3VytzSUkzdXF3Y1RuUGhHMksvNzBWK2lOMkNJWXVaUG9kd2tHNzdzVVFQ?=
 =?utf-8?B?UDlqb0lUc2lOMVhLZ2tyTzJTOEtTN25pVThydE54cldCUko2N1NjNkVWWTB0?=
 =?utf-8?B?YTFpN0tLOU91TkFVVzJXWkF2a0lSbHBJSHFoZHVPTjUrcjk2UWMvVlFVRzdX?=
 =?utf-8?B?cHpBa0RKYnBQZkMzeU93cDhLQ2pqT0NtaW81WUU1Z1EwdTZVaWQ1bHJMemZK?=
 =?utf-8?B?TmdoZzZTbDVkZ1JJV1dRUHl1WmpyREc2YzNBSU95WDRoSVpHRThLLyt6dVlt?=
 =?utf-8?B?UWJLNmNQTzRRUmRJYlJYSFlRNU1sNklYU29WZ2laUWQySERYbHo3ODE5NXA5?=
 =?utf-8?B?TXRQUlZjRi91ajZiVkY1QUZhaXpTMkdyYTNGOVdEeUFjS0xMamJsL0UxaytW?=
 =?utf-8?B?dDN0SDBmT0x4ei9TNzd1NmE0N1MzOXlXN2RVRm5Cd1dXNGZ2V2dEbm9jd2U2?=
 =?utf-8?B?V0g5eG8zV0F6NWlUTzhadmttTGVpbU94Qk1uWTRJYnY4MFlyT2lhU0pnYklo?=
 =?utf-8?B?a1c1RlhpOHRjWHJSZ21GYmhicGhaejlLeTEwOG1mNUduejdlWWVwMGdMNktx?=
 =?utf-8?B?UFhRWGliUnFIWk5vVkFPcFljbllmazVydVpjNEdieVc1b0xEeEZ5amFlRDhI?=
 =?utf-8?B?SGNMVUdjZlRLais2YVNCM1ZPZnlBTTh6b0ZVWFBwVFdsOVNnSkltaEozdGVn?=
 =?utf-8?B?RUpNUHZScFltc3lyR1Z5S09jVzF0MUZyOWRrYW9IL2s1OUZMM05acWo5Vm5B?=
 =?utf-8?B?aG5GTGFGUEpMYTBiNGdrMWRmemxTQWU0bWFYMThSU29TTlUrR2JYWnl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU05SHlFQ0dpc0c3ZnFEWVRHR2QrbTl6cTNFWllSMlhSRS8yaVNwOTJmdWU0?=
 =?utf-8?B?eWZOdGY5K0VpWW9MaWt0enhpdFFyQWllcWRteHBzaUYwYi9CTHQxV2VLQkpJ?=
 =?utf-8?B?eDJ0aXNQY011S2ovMDlGZ1B1eldvekFubnNjVXptdnc2Uk1JaWhFRzZsQWZo?=
 =?utf-8?B?TmdzaWtlU25yVElwSUJkanNWRjM3c0pMRmV0aDUxM3puZWhzVXhFejJhN0t0?=
 =?utf-8?B?ZmpTd1dWSWNRd0o0aWhRemt4WVJXOHJPdWFJREViZ0swcmh1NUVyQ0Q4V1du?=
 =?utf-8?B?M1htYVBhMUFLZE5ZMG8rTFR6S3hndXlWSzByUmhjMjQvOXgvWFFYQTVUSzNM?=
 =?utf-8?B?cjdHY2Y4SlFWVCtObFRUVndZcTR5OGc3aU1CQVNxelpiUDB1VUZXZERoa1hU?=
 =?utf-8?B?Qm9oY3cxOGhHZE1lcXlUeE45YWJhK0hsMU5mVEtPOGo2MWV2VGE0c1FrZHc1?=
 =?utf-8?B?TXpsV202QjJrdnNLSlNnaGliV2NBemUrc3E2U0YxS3NISkRNcWQ4bUo5N3dj?=
 =?utf-8?B?aXNZUUNHRDVoaE9MdmZKanNjUmNLK2lrNFRyaVZqZ2ZqOUdOYnd2R2FvenpP?=
 =?utf-8?B?eW5iM2RpVzdhcGVTVjNueXN6QTJmMlUrRHJvTDV0ZWpxaFRVV3p4dFUvNzNi?=
 =?utf-8?B?bk9sN0JGNFNWNFNVc0k0L2N5UjVHU1BkU1lyMlhvZlg1UjNWejFMUEk4VkhR?=
 =?utf-8?B?RERTS0R5V042SnhTak4rQnRsMnBsTTViL1V6UjYrYjZ2MDY4dTdKZWM4Nktj?=
 =?utf-8?B?ZzdmUjhYMlZaZ2Q2dk9lTDY3Y2FRNUxaMnBEbEpYYW9wSWU2cCs4UjRnQ1Uv?=
 =?utf-8?B?akl5cVk3c1pha2Iwd1pQM1NqNkN4SFZ0emJEVkFaYW9QMk9pQXpHOWQ4cWt2?=
 =?utf-8?B?RGgzVm5Pb25QMU5LUi9CTzNLdVlLZGhPZEtJVE12em9nSGFEbDBkcmVqaVBz?=
 =?utf-8?B?MXlVcExnRnpaa0dPZmhZbndoY0tIOTMzS0g1SkdqSmpjVUdkS3AzWGQ3UGJl?=
 =?utf-8?B?bW5xK3NLaHB2Vk9Qc3lXSzNDZUNKL1N4RlgrWkc4S2x4OUsraHJhSEpOdDh2?=
 =?utf-8?B?TjhZUXdNUUV5dTBRZjh3akJDTnlYSUN4UjUxSW9yQy9uMGFJcGlOdG1aZSsz?=
 =?utf-8?B?RVdKcVJXUVE2bnB0YUlVRmVpMmxKdmcva2tIR2duRXlONC82VEkwaGM4Qk83?=
 =?utf-8?B?ZTNJeW9uOUJ4bnJmNTRzVlJHN2V4dnp5NE5KUmJoT3U2UXZObmdUcUtidmF1?=
 =?utf-8?B?UURiU1VuV0lVWGxNNHptMDFLWDRSMUtsOGVneEtKRTA1eFJkeVFRTjhOR05H?=
 =?utf-8?B?b2xjWEthaUYxYVJhQnM2YjZ4UWNJN1lJbzhHZUo1dURDckdTN2xjZU1nN1g4?=
 =?utf-8?B?R0NmYkM0eGxPaXlJdFc4MU5KcXN5L1BEMmZneXMzSTZXRUwrc1NzVDNSazhw?=
 =?utf-8?B?SkVVemxZeE56bkdRZy9wSTRJV3hqS05TZS9pdnNsUy9pbXlBQTZJZXZGK0Ux?=
 =?utf-8?B?NG5rd05wRDlrMkw3azBpY2J0TlBRQVFrK3NPUXh5TWdUMkZydHk0ZXdRQlE3?=
 =?utf-8?B?NFAxUENwdW0reWJyWVdFZng1VElUaTB4bS9jOVNDRGJweXAzbU1JNGtPS3NQ?=
 =?utf-8?B?V1B2YnBVeTJBVEVhTVlaUlR4ZHF1VmY4Nkp2RnlzamYwYzFKbElwMm1Ja3VM?=
 =?utf-8?B?cXBwZURzbEI4dEhnMU05SjY2MzdWVWZOQWJJRWw3eVVjWGwrdDRMelowazlv?=
 =?utf-8?B?VXQ2bkZnY3Q2V1dQenlvcVNPbHc3WEZZRzViTU03djNjRGFRbHpIMDhVVTR5?=
 =?utf-8?B?QUlWWkFiNXBqYXpMMmx1WTRtdjRiZ3lzc2YvNWFhM3hINlRXS3NWQ0hMODQx?=
 =?utf-8?B?RE9qTnU3U2d5OXZBV1dvd0hldzRKbjVjNXZ3OU9zVnNwVEVNdWZ3SXhzQi9z?=
 =?utf-8?B?ZDlsSE83b080Sk1EeXVFTno4dzd2Z0lUMFZtQ1g5dkxVb2FUSW11UHdFVFZj?=
 =?utf-8?B?SUZGUGN4NlE1cVUzTHBVdk9pTGhNbGExZjRhQ0pqL211aVZDOTJ5UDFjbzhM?=
 =?utf-8?B?TXNIbVVZTVJZNGlmeld2K2JFeUpkVXhiNnpwZ00yMDBZMCs2dzBmMUZaTUpL?=
 =?utf-8?Q?agdSnrmjgcFf8hIq78V00YGKa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b11a05-0205-4296-c7de-08dc80e2d030
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 19:58:02.5714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asWHKju3/kJAy/WqFe6RhPoesJeTBQWcL2DVDwDBfZFclMnjUjBLsv0BTl+zA9WHd5yWK/tKTYK+/t6y8rkGhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
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

On 5/28/24 08:57, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Currently when one enables driver debugging dmesg gets spammed, at I
> suspect vblank rate, with messages like:
> 
>   [drm:amdgpu_dm_atomic_check [amdgpu]] MPO enablement requested on crtc:[00000000f073c3bb]
> 
> Fix if by converting some logging from deprecated and incorrect
> DRM_DEBUG_DRIVER to drm_dbg_atomic. Plus some localized drive-by changes
> to drm_dbg_kms.
> 
> By no means an exhaustive conversion but at least it allows turning on
> driver debug selectively.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Applied, thanks!

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 ++++++++++---------
>   1 file changed, 39 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 975feb1c69b8..bf9db488eee6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2363,13 +2363,13 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		if (aconnector->dc_link->type == dc_connection_mst_branch &&
>   		    aconnector->mst_mgr.aux) {
> -			DRM_DEBUG_DRIVER("DM_MST: starting TM on aconnector: %p [id: %d]\n",
> +			drm_dbg_kms(dev, "DM_MST: starting TM on aconnector: %p [id: %d]\n",
>   					 aconnector,
>   					 aconnector->base.base.id);
>   
>   			ret = drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
>   			if (ret < 0) {
> -				DRM_ERROR("DM_MST: Failed to start MST\n");
> +				drm_err(dev, "DM_MST: Failed to start MST\n");
>   				aconnector->dc_link->type =
>   					dc_connection_single;
>   				ret = dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
> @@ -3298,15 +3298,15 @@ void amdgpu_dm_update_connector_after_detect(
>   		 * We got a DP short pulse (Link Loss, DP CTS, etc...).
>   		 * Do nothing!!
>   		 */
> -		DRM_DEBUG_DRIVER("DCHPD: connector_id=%d: dc_sink didn't change.\n",
> -				aconnector->connector_id);
> +		drm_dbg_kms(dev, "DCHPD: connector_id=%d: dc_sink didn't change.\n",
> +				 aconnector->connector_id);
>   		if (sink)
>   			dc_sink_release(sink);
>   		return;
>   	}
>   
> -	DRM_DEBUG_DRIVER("DCHPD: connector_id=%d: Old sink=%p New sink=%p\n",
> -		aconnector->connector_id, aconnector->dc_sink, sink);
> +	drm_dbg_kms(dev, "DCHPD: connector_id=%d: Old sink=%p New sink=%p\n",
> +		    aconnector->connector_id, aconnector->dc_sink, sink);
>   
>   	mutex_lock(&dev->mode_config.mutex);
>   
> @@ -9191,7 +9191,9 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   
>   		if (amdgpu_dm_crtc_modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
>   
> -			DRM_DEBUG_ATOMIC("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
> +			drm_dbg_atomic(dev,
> +				       "Atomic commit: SET crtc id %d: [%p]\n",
> +				       acrtc->crtc_id, acrtc);
>   
>   			if (!dm_new_crtc_state->stream) {
>   				/*
> @@ -9209,8 +9211,9 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   				 * have a sink to keep the pipe running so that
>   				 * hw state is consistent with the sw state
>   				 */
> -				DRM_DEBUG_DRIVER("%s: Failed to create new stream for crtc %d\n",
> -						__func__, acrtc->base.base.id);
> +				drm_dbg_atomic(dev,
> +					       "Failed to create new stream for crtc %d\n",
> +						acrtc->base.base.id);
>   				continue;
>   			}
>   
> @@ -9224,7 +9227,9 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   			crtc->hwmode = new_crtc_state->mode;
>   			mode_set_reset_required = true;
>   		} else if (modereset_required(new_crtc_state)) {
> -			DRM_DEBUG_ATOMIC("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
> +			drm_dbg_atomic(dev,
> +				       "Atomic commit: RESET. crtc id %d:[%p]\n",
> +				       acrtc->crtc_id, acrtc);
>   			/* i.e. reset mode */
>   			if (dm_old_crtc_state->stream)
>   				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
> @@ -9679,7 +9684,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   #endif
>   				if (amdgpu_dm_crtc_configure_crc_source(
>   					crtc, dm_new_crtc_state, cur_crc_src))
> -					DRM_DEBUG_DRIVER("Failed to configure crc source");
> +					drm_dbg_atomic(dev, "Failed to configure crc source");
>   			}
>   		}
>   #endif
> @@ -10851,7 +10856,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   	ret = drm_atomic_helper_check_modeset(dev, state);
>   	if (ret) {
> -		DRM_DEBUG_DRIVER("drm_atomic_helper_check_modeset() failed\n");
> +		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
>   		goto fail;
>   	}
>   
> @@ -10866,7 +10871,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   		new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
>   		if (IS_ERR(new_crtc_state)) {
> -			DRM_DEBUG_DRIVER("drm_atomic_get_crtc_state() failed\n");
> +			drm_dbg_atomic(dev, "drm_atomic_get_crtc_state() failed\n");
>   			ret = PTR_ERR(new_crtc_state);
>   			goto fail;
>   		}
> @@ -10881,7 +10886,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>   				ret = add_affected_mst_dsc_crtcs(state, crtc);
>   				if (ret) {
> -					DRM_DEBUG_DRIVER("add_affected_mst_dsc_crtcs() failed\n");
> +					drm_dbg_atomic(dev, "add_affected_mst_dsc_crtcs() failed\n");
>   					goto fail;
>   				}
>   			}
> @@ -10898,7 +10903,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("amdgpu_dm_verify_lut_sizes() failed\n");
> +			drm_dbg_atomic(dev, "amdgpu_dm_verify_lut_sizes() failed\n");
>   			goto fail;
>   		}
>   
> @@ -10907,13 +10912,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   		ret = drm_atomic_add_affected_connectors(state, crtc);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("drm_atomic_add_affected_connectors() failed\n");
> +			drm_dbg_atomic(dev, "drm_atomic_add_affected_connectors() failed\n");
>   			goto fail;
>   		}
>   
>   		ret = drm_atomic_add_affected_planes(state, crtc);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("drm_atomic_add_affected_planes() failed\n");
> +			drm_dbg_atomic(dev, "drm_atomic_add_affected_planes() failed\n");
>   			goto fail;
>   		}
>   
> @@ -10952,7 +10957,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   			if (IS_ERR(new_plane_state)) {
>   				ret = PTR_ERR(new_plane_state);
> -				DRM_DEBUG_DRIVER("new_plane_state is BAD\n");
> +				drm_dbg_atomic(dev, "new_plane_state is BAD\n");
>   				goto fail;
>   			}
>   		}
> @@ -10984,7 +10989,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   					    &lock_and_validation_needed,
>   					    &is_top_most_overlay);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
> +			drm_dbg_atomic(dev, "dm_update_plane_state() failed\n");
>   			goto fail;
>   		}
>   	}
> @@ -10997,7 +11002,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   					   false,
>   					   &lock_and_validation_needed);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("DISABLE: dm_update_crtc_state() failed\n");
> +			drm_dbg_atomic(dev, "DISABLE: dm_update_crtc_state() failed\n");
>   			goto fail;
>   		}
>   	}
> @@ -11010,7 +11015,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   					   true,
>   					   &lock_and_validation_needed);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("ENABLE: dm_update_crtc_state() failed\n");
> +			drm_dbg_atomic(dev, "ENABLE: dm_update_crtc_state() failed\n");
>   			goto fail;
>   		}
>   	}
> @@ -11024,7 +11029,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   					    &lock_and_validation_needed,
>   					    &is_top_most_overlay);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
> +			drm_dbg_atomic(dev, "dm_update_plane_state() failed\n");
>   			goto fail;
>   		}
>   	}
> @@ -11040,21 +11045,21 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   	/* Run this here since we want to validate the streams we created */
>   	ret = drm_atomic_helper_check_planes(dev, state);
>   	if (ret) {
> -		DRM_DEBUG_DRIVER("drm_atomic_helper_check_planes() failed\n");
> +		drm_dbg_atomic(dev, "drm_atomic_helper_check_planes() failed\n");
>   		goto fail;
>   	}
>   
>   	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>   		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>   		if (dm_new_crtc_state->mpo_requested)
> -			DRM_DEBUG_DRIVER("MPO enablement requested on crtc:[%p]\n", crtc);
> +			drm_dbg_atomic(dev, "MPO enablement requested on crtc:[%p]\n", crtc);
>   	}
>   
>   	/* Check cursor planes scaling */
>   	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>   		ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("dm_check_crtc_cursor() failed\n");
> +			drm_dbg_atomic(dev, "dm_check_crtc_cursor() failed\n");
>   			goto fail;
>   		}
>   	}
> @@ -11137,13 +11142,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   	if (lock_and_validation_needed) {
>   		ret = dm_atomic_get_state(state, &dm_state);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("dm_atomic_get_state() failed\n");
> +			drm_dbg_atomic(dev, "dm_atomic_get_state() failed\n");
>   			goto fail;
>   		}
>   
>   		ret = do_aquire_global_lock(dev, state);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("do_aquire_global_lock() failed\n");
> +			drm_dbg_atomic(dev, "do_aquire_global_lock() failed\n");
>   			goto fail;
>   		}
>   
> @@ -11151,7 +11156,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   		if (dc_resource_is_dsc_encoding_supported(dc)) {
>   			ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
>   			if (ret) {
> -				DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
> +				drm_dbg_atomic(dev, "compute_mst_dsc_configs_for_state() failed\n");
>   				ret = -EINVAL;
>   				goto fail;
>   			}
> @@ -11160,7 +11165,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("dm_update_mst_vcpi_slots_for_dsc() failed\n");
> +			drm_dbg_atomic(dev, "dm_update_mst_vcpi_slots_for_dsc() failed\n");
>   			goto fail;
>   		}
>   
> @@ -11172,12 +11177,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   		 */
>   		ret = drm_dp_mst_atomic_check(state);
>   		if (ret) {
> -			DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
> +			drm_dbg_atomic(dev, "drm_dp_mst_atomic_check() failed\n");
>   			goto fail;
>   		}
>   		status = dc_validate_global_state(dc, dm_state->context, true);
>   		if (status != DC_OK) {
> -			DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
> +			drm_dbg_atomic(dev, "DC global validation failure: %s (%d)",
>   				       dc_status_to_str(status), status);
>   			ret = -EINVAL;
>   			goto fail;
> @@ -11255,11 +11260,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   fail:
>   	if (ret == -EDEADLK)
> -		DRM_DEBUG_DRIVER("Atomic check stopped to avoid deadlock.\n");
> +		drm_dbg_atomic(dev, "Atomic check stopped to avoid deadlock.\n");
>   	else if (ret == -EINTR || ret == -EAGAIN || ret == -ERESTARTSYS)
> -		DRM_DEBUG_DRIVER("Atomic check stopped due to signal.\n");
> +		drm_dbg_atomic(dev, "Atomic check stopped due to signal.\n");
>   	else
> -		DRM_DEBUG_DRIVER("Atomic check failed with err: %d\n", ret);
> +		drm_dbg_atomic(dev, "Atomic check failed with err: %d\n", ret);
>   
>   	trace_amdgpu_dm_atomic_check_finish(state, ret);
>   
-- 
Hamza

