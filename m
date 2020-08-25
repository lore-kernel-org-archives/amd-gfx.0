Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DB4C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1C72072D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sPmOxQxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1C72072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7136E42B;
	Tue, 25 Aug 2020 14:30:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A3D6E42B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 14:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DePWgM3UReZ+ZwIrO419t/IAioF/r9KZzEIlTlqO6nsYhxNACKtnRZarhipvud7FOtwiJIEJkVCqOdX072VL0JQ1KeODcdJIUK6mx/aNBRVmYbNX1CBj7GLvDN6/Dqg5+WVEKvU7UnUOppT52MH9vojoDRFSVw+aLwYTnOtGjuySy/kAdIXlwjSkrTPVTCCluo6mzlMt/+JpMkeq0aWcfookBfk8DyYzK7XeFbyhpP1IcLvVnL/Keq+ng6MAALLHjCU8izdCc+GVLjczXwrGjvgZDBaKx8ZyXWcXCE6HoASN0vJW9vPBGnWJ8JKUTVtrDDD/BPicTCkGUN36bpzI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q45/nwRTAzT7SLG4d/9H04P6ViarJgv48ZIKJ2Dt9m0=;
 b=ii8P/049rCso5cMnIfB4iNRcm1Py549CNsJqpI8QBLRxGAP+taZrkyTpV+EWDy5Nzie9qTpW5EyEYhCp1fOqJPfPjshuvziZbFpJPhd3JgAUcbw19u94ACPdHtbFaEMkg6UyOOzoeDNc0ICsXLf1patXFScYjUe1iB0lDpd/D3jxqqf0bFqbZBE+zNDUvnIuaQjjic2W+j/BOMjULW+SQVnSZEehXDcaypdqWuYrCMyu9fG08Ao+gFn1ioGG4gfn5FRdMMJ+ujiWOuCq7ex4VbGCz0e+1q8GNI+hyzSKIHyRlCd8EaC6wW/b60tuDTrygwUjItkqgtvfACzOe+tSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q45/nwRTAzT7SLG4d/9H04P6ViarJgv48ZIKJ2Dt9m0=;
 b=sPmOxQxCWIOTgzrdvV0LQi8ZMBME19HWT+ZAkKm6/w9ASVJh4ACJcY4esaMoISiI45uG77mrfEf/KS4nNy5kfo5SMG4pU/1PTnbmVdvyOiGcoXb+ZuZacoPEVz26XfmQPThFpShduw0Zu+xV3dAHVt8stYY5x57EsbxsT1L43ME=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 14:30:23 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Tue, 25 Aug 2020
 14:30:23 +0000
Subject: Re: [PATCH] drm/amdgpu: report DC not supported if virtual display is
 enabled (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200825141808.300152-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <01fe612b-be52-e0f2-3351-2a4969f214e0@amd.com>
Date: Tue, 25 Aug 2020 16:34:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200825141808.300152-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR1401CA0003.namprd14.prod.outlook.com
 (2603:10b6:405:4b::13) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR1401CA0003.namprd14.prod.outlook.com (2603:10b6:405:4b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 25 Aug 2020 14:30:22 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50a37d07-f055-480a-3a97-08d8490366d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4139:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4139A062AE534FE85960A84F8B570@DM6PR12MB4139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ESkCyFoVEPKCDoPa6nHDXxkJkIM1FNQzJzTol1FrMVTZDQa186jZlGzgfx3lKDSE/4QUZdZjfHvlYxzPDGMcRtfy/6EzUqvR+VB8AEqQ3IOoDYTRdH64IZGMqSMx77ZasjcHQjpcJ4dAvUkOyCxLw5M2TUWKclJijNbdiwz1sPhHHXzbkzcO4Z++e/lr8jDPiVrkr6tognAZi0BvOGwdCFYiHNoitaj2jby1J9olPLiH1cMSFfTwtFgGOuvhRlRMzGkiVwk/+mIGcXcqM5lMQd4BwKbnefkKc3PndpDHFmk/C3onYals0Rfj0Sfqo+oZxJvEswOOoXlBewPsPHFhsUTq4Q4OI5ZEMhKp6fYn+b6MGPqbk8ElH4K5iyrfOlk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(26005)(186003)(53546011)(6486002)(31696002)(956004)(2616005)(66556008)(83380400001)(66946007)(8936002)(66476007)(52116002)(31686004)(2906002)(478600001)(16576012)(8676002)(36756003)(5660300002)(4326008)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oPmCNXXIYCqoBXycqsPgkGgmveMEPTGyi6so7XVHfPs3ci+8j5Zd7C3jx9EUhZiam5YVV20q5fe40qK5rIdUzD45nFTn2B+JTYx0w7nzQSp0X3mygLcSOZB3nrunzMwv5OubCS0cbpDarIiA1UD3Jm+JJbdhmZWZFJriK4TDHqVHUnVRcTihl1f9HgjPEOvqgSqkmQqZWSB5TitHKvYY5i7G1eDcog0+/rVmhxlcRLcIxvuC+4PANlLeYL6tq79inhuoLMTowhcYUW2ZhlJwWr7pB/iYaz9zZTuaXFP221laPSopl0v+YUHUI0XJDGNHahlKfth6ycoF4r17EQrX3bNd4GTyN1UrMsiFFSUR/sABfEH1KE4uXrOMGsofZfY4oer1t0YEFLJi8TsM8lwoiT8L6Fpl4YSD5KZtVX7W2poT3iseMme4FEeo5RdgPdR8iaa2B0hRlMhHiOJl+5yqCHsS0SaTYrfejvD+syddjSdU9ma7xw35MkD4dn9BDvEOfLDgsOcFkFOPFDM+0eOZOMd0aOOHd0WxqWDOPdpbYVkHRQBRIjJgc9UV4EkRA/CcLREj502i5s7n0XRGHSCW7wVgyXo4nWbcYXb605QOjONBCjbhiPGmQHrKiBKCwr3ir7geO6hioB3E14Wr8qjdcw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a37d07-f055-480a-3a97-08d8490366d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 14:30:23.4452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVi7Cy72mEaYvT+fRsvlXcFS7gUoXxLQjnNih8podblm4CibT7jLKh4ZzaP0r5a4PJv2ZG08AFhdsuORv5mBgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/25/20 4:18 PM, Alex Deucher wrote:
> virtual display is non-atomic so report false to avoid checking

With below nitpick fixed, Acked-by: Nirmoy Das <nirmoy.das@amd.com>

virtual --> Virtual


Nirmoy


> atomic state and other atomic things at runtime.
>
> v2: squash into the sr-iov check
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5a948edcc93c..8f37f9f99105 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2861,7 +2861,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>    */
>   bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>   {
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
>   		return false;
>   
>   	return amdgpu_device_asic_has_dc_support(adev->asic_type);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
