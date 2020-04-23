Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353B1C54FCB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 23:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A984520780
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 23:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wqO0ekAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A984520780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550DA6EA3A;
	Thu, 23 Apr 2020 23:00:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611B26EA3A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 23:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJPuP8mRgBnSggb16NALYiKkYovzdjxB1MZnj+NkMRIKqqUNw1U4Ndp/I1yREUgai5lvFmuHnk3OHV3t07rLfTfsZgjYYcmj69XCO78WlzYurfYwe9dFeKmqM1hhyz4B88BSej0FgbTef5EK5Z3I4AgZ9Qyq3fXx/wakC1tlbVOCArs4zg3g0hTPv3FL77YeNdF18SyGXy8N3DBNIcf/8cDH1NON2x6M/CReQnM6jLam6Gu3oJJSIWK3vkQYFAtJ6F0KzrulEMpcB2FNEBromifKBgvnN59eog2Lxnp8SyOVq5qgT8Gj68EITHW3vs+O/8e9JSKo6jE6UZ4LNtKY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0Kf5++qyzYURbt5/7gAmEzEtGTrx88A68KzE8TNMsk=;
 b=eLoJQGu1qvbwz7+FkWYN7roYW/3qUELmVHkww0Ie05qZumk7SeJg54a3DlDaoL8KNgdVEDsgLj0cU1N0oTdpYic8KnSHsAZDguSmoz31QZTVlev2gpOk65BlWwSBlSJYI9okMS2Ug8O2tEaPKoCEwv0bhrf424fjBbft0wplxw8yTCmQ+GZM4C1DYhkjaa5Au2paT3VcAGjijLBiGUERXb+Sgi/CNzceg2z4PlCjFfADP012CKq3JNFmy6cavthT+nsp53e19uZewYWJVdizj5US3HGsAHMKeT18edc/ERIn5P92UgLHSxoJUh5Ss9WMvIape+XqU4hmPDmJ6AlsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0Kf5++qyzYURbt5/7gAmEzEtGTrx88A68KzE8TNMsk=;
 b=wqO0ekAB27aiovfQm7h0sysG2nUgeqnGYet25h5Psa39ybHGFthJH4F5iSxdpWq9wm5Ujspx1LgXakoiwyKRJH+W+15H/v0/UHbaa+MwVx/PxiIPX2R7L6mEjBBHLGMK6TrYxehC0psyNH0o1M7SNXu2LLlqzYfBnBFgPdNMZg8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Thu, 23 Apr 2020 23:00:28 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::943d:4dcf:f18e:5df]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::943d:4dcf:f18e:5df%2]) with mapi id 15.20.2921.033; Thu, 23 Apr 2020
 23:00:28 +0000
Subject: Re: [PATCH] drm/amdgpu: check ring type for secure IBs
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200423204720.1063581-1-alexander.deucher@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <30c3e28d-2d20-4bd8-1330-7d82bf4c93f3@amd.com>
Date: Thu, 23 Apr 2020 19:00:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200423204720.1063581-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN8PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:408:c0::22) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.5.43] (165.204.84.11) by
 BN8PR15CA0009.namprd15.prod.outlook.com (2603:10b6:408:c0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 23:00:27 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f346849-c23b-434c-14f6-08d7e7da1d43
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:|DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2986B1AF5DC63A5F71FE34A7EAD30@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(26005)(31686004)(16526019)(36756003)(66556008)(186003)(6666004)(5660300002)(66476007)(478600001)(6486002)(2906002)(66946007)(4744005)(4326008)(8936002)(2616005)(81156014)(52116002)(8676002)(31696002)(53546011)(316002)(16576012)(86362001)(956004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOKWaCakDphw0rwLeavF2TJj7O06L8K7ZvBMpcXwA78utC4OjfoU18fAZkO/96rfv8bR675+48RlPYZwQ5BLE7i9bUB07hZdH1IuuvHaf0LMh1NrqjULIEgLi+rQyWdWIVbknzcnEc+krUOd4PksKFgOjR5QkE3LruldiuZrh70Fx03wVK6v1L03MA6VASiWCOIfU8sNBD11XLbQ5yfK0pN8V7hYxXEjml/l0oBffmJXorrtYyqNlfvbqwGI9h4C0mKBDZ36tGxLgSp0XEIv9XrnruGIdVbk6agqsh3zLuXdC2PfPd812fNxOweTa/Vzpn31lr0QooCitPyqYRoJQagH6x+xEDK5LjQdjczDhbF1+33+PZf+X783pAD1ajLGSZIo9ofVKP+csznBMfzXJkQi4H4qUJ6hVSJOwJJlCcDNU6T6bPmx+WJYenNbEiMt
X-MS-Exchange-AntiSpam-MessageData: reqxkDHiTqINmjX/4xgPddjbayCaotGSYwdfajQn0Nf6Aogp6aTxUah1qqB1GNIt8dr8LgLNdmhQrKsoexCG4W/RlOGnTwBg5DUyzmDjn3z4fc74xBcBfTGZWuTEDxaoWejDNoGHJUJPaCZ59xKo7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f346849-c23b-434c-14f6-08d7e7da1d43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 23:00:28.2259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kffSf+yoirjtDe7u5NpU1uX8WXQj+qPNWftTRPUpzsvoFv9I+7Avj4qN0gVj0CSn+aaWPmqqtgSJ+ElnY2Zxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 4/23/20 4:47 PM, Alex Deucher wrote:
> We don't support secure operation on compute rings at the
> moment so reject them.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index ec2c5e164cd3..b91853fd66d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -161,6 +161,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		return -EINVAL;
>   	}
>   
> +	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
> +		dev_err(adev->dev, "secure submissions not supported on compute rings\n");
> +		return -EINVAL;
> +	}
> +
>   	alloc_size = ring->funcs->emit_frame_size + num_ibs *
>   		ring->funcs->emit_ib_size;
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
