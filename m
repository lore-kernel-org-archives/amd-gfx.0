Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA53C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE70861078
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE70861078
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7AEC6E8CB;
	Mon,  7 Jun 2021 13:51:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E81F6E8CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmRgsyEOy4SuC7qEgFbKYST6NqHE2lscecvXp2h4BbJIakfGOMq/2ZYURWlQ7mJPvneQtgz1VcnCYnLkgsZTJ0yqREh0tI3Oxq7eWADsoMc5GzSJgwDbp8xbpbJ1lpbifA4ItS2myxLUdNPj2qtN5CR1y5JIUZ1Je+H+Yu0pUf+X1dRUpmyFu6nvRTUb8Y5xHKyVNSTJgjTtpRJUrCWgkCPp70FdRPixtvNoYHKJr7Bhsm3cDyy4qMkHmQvHVLtux3vistlZBzKqWgJ1gV0F/Mt/fndd64tM3/2hQLtP2FWSm1J9I7YnHWT3p47gVR80r13GAOzqE9qcAlm48o73QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O56OAQMt0pCuijghLE1ooDBy59A31k/2HriRW670zY4=;
 b=OEDMSGsYpQkdq3htZxyqahMQcLybogSST4N7FbAAuqQGNNEtTOuz6eE03xKQH8UrOemX4H6v+xcuGvS3i4balpplT+XMTWyVO0NYristsZM+Ufyg+Uxc5HVVz+8fdU3RgOySCisUhBrH0M1wYyEpwpxDPWXJGwOwzXDccVCrPv6dhqg1GNeb+kbQEXfs9tYEBh7t10J16LitFDv7Uu01/wgdrPGIZ6016uHcqqeIJebtfhO4oTXL70Y9hQjrncCWwNSYsnyZN8h35txQG84SpPfST2yFlKNgWrfhmfgJYx/39+I+8b9H0Xc+C13mQralEnK21OSRTpUjO+D2ApqLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O56OAQMt0pCuijghLE1ooDBy59A31k/2HriRW670zY4=;
 b=yEykmq5i3QjDamQuF56iJZQAlgRGxfYaO4GHugag2gJ1eXMVJzX2B23lIjUB3bnGAjuLTJpXXo049DezdISiTWNSEFE+JSsaqAyvYxtJ4j6zzSxyKbUPJFL/+nd96X7Ddq0yt/UILe1QS31cdekPx3bsHhGGT5jJAjURC/IRJEc=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 13:51:46 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 13:51:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Thread-Topic: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Thread-Index: AQHXWIKm/jDurmYqOU+XrKMG9mwbUqsCZMYAgAAFTICABixDkA==
Date: Mon, 7 Jun 2021 13:51:45 +0000
Message-ID: <BN9PR12MB536854A30D4B84DF839AD285FC389@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-4-zhigang.luo@amd.com>
 <DM6PR12MB55344CFCAD9394BC48B36665F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
 <BL1PR12MB53179B09844D1195B7DB3B47F13C9@BL1PR12MB5317.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB53179B09844D1195B7DB3B47F13C9@BL1PR12MB5317.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-07T13:51:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=537b63f2-7f85-4b82-902d-0032578406c4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81ee46bf-b4dd-4be3-7b33-08d929bb63c8
x-ms-traffictypediagnostic: BN9PR12MB5243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5243C791DADA85DE12D59747FC389@BN9PR12MB5243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7eZ4Ah7BLi1H+jLeRjPd76DcL9JGV0wtmBjs2ik9qiDPcA/WzEElYxbKhasFbbv8SDJVF5GUgL4J5HAV8BGxiz3Zfp+D5d6rM/HET0Nvb3F/EndHaSzHRc2I+pilIjG6jSHb5SBF6kZ5CCbeS7CQdvKIxvgr8cqXRtZ5C2K/10DQNdhPIx9zPLpoc1cD1iTXjrfnxGX/QBxOPQcAUEtQu53Yhyz1P3w/qS+BM2s2MDQQv2hfcDeZkszWouMCSGxizeCys15LheYr3jb0wpzMbz3myReQBx0KYV0+vJLhdyKUm8hQw0atdvCoo/ILvyP3GMNbGVEX7nBauGDt1dtgCsxbZ5l/6ff+DehzcXGphNi2h42bO7b8XF+5EbwwMUzU4rQBahahc6zVHGd0UhlIiX4m59ofq/blgd8sdiv+PkSHfx/+MKU1w7/mEf0GHMT5LKVRMk6DthOq7IX+nRY6f93iPFc5vas6i9lmcLSarT//iinIUIUcK1284BxCgyPUDZalH+qA0OH6XSUzR12M29su/kER+oTrcAPHnoW8M5xsdr6uyY82LDNeZc1jOOcbrbnCThAoM/9Ji34Tojr2aqD7U6KWiN6XPg6MjiaWjSfDvPmf+lV7Qa6tGY5b/+M8ekNu2sw+mm9i6BkRshd9Hw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(316002)(26005)(110136005)(66446008)(122000001)(38100700002)(76116006)(64756008)(66556008)(66476007)(66946007)(45080400002)(9686003)(478600001)(2906002)(53546011)(7696005)(6506007)(55016002)(8676002)(71200400001)(8936002)(966005)(5660300002)(33656002)(83380400001)(186003)(52536014)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Gc9pbTnOGJKUe3pG7uIl6FThiI5747fx/oK48biQdY1USxMAOEJZq6lEXSwC?=
 =?us-ascii?Q?adPclEnjriRN+ezyFSnyhUVxU8nQV+iiyOi5uZcfZIc+wpBOL3JLmwd9bYCm?=
 =?us-ascii?Q?E34WTuC+m2FH/LHpwTeBh90G8f3qyE6frBzo+50DxsyFNM5tm+feCIb/tv8Y?=
 =?us-ascii?Q?G+9nBPByZDZcapVAwf78TrPdRjO3NF2RJoPTBaosNxUN3VLhaM8/gLTcf0Ye?=
 =?us-ascii?Q?XYfXOg+7DHFHDcO6Pjv+tkx95ms9wGd2Yrl8tI/FzKdu2a6LDqoxH+wNHh5e?=
 =?us-ascii?Q?yeLGlRSzMJDegou0TnZXPlEgtrC4ZcRhroDKJAS0hR60J5L7ywzH/XygTE/j?=
 =?us-ascii?Q?YQZ5GSiXRVTP8/EwDVXUJ9pad0VxoXUChpfHHlP6BFr9waTFf8w+jHQSU7Yy?=
 =?us-ascii?Q?1ygiPhA+ZnIK6eG3H9MgrQ5QrckYUitcUCSxURazYj8ZqBem0d+It4Vu2y2M?=
 =?us-ascii?Q?nlGJh3WOs0RsUzhvSTtvGE3aK3PoLZqIAKUHwg9RNzgruGornmmF18gJqhMB?=
 =?us-ascii?Q?oBRbGWup6dhfawp9Q50KvxHyUSx5MHE8RarhYURdiG1FypqAeklWc4qM3pWQ?=
 =?us-ascii?Q?bGyYLwMWVIBhx1SQDaKF7WZxE5VqqO1WVfOT/nZpHc1bcfnSfmWbj5AaknuF?=
 =?us-ascii?Q?9XUIJ3UlbtnYRhwOlvj0ohKC9Gk0OfNC7BtOV4lYZme4YLAWkbOqcQX39LLH?=
 =?us-ascii?Q?ATCLZ189xEVCtNBi6N5iV4yu2fPgdilPuqkKoqyV12HM3iZI2JDEPPO0Qi6A?=
 =?us-ascii?Q?FijVfdj8a7g3mpjUExZiwL1yZur8wAFCJ/EImAuRE5/lc5aYwcXZH1VR39CZ?=
 =?us-ascii?Q?mxvZZiYb5WqUnJVYBMPd1q2mx0SBIDMZY22wCdsrQuCsy9MUENG+qH5dDdnG?=
 =?us-ascii?Q?+Gi1ZWmm3h2Zi6+2GKj8aF1GqnIPQTmW2q67HFsyRrQiRKo1vxzJHFtdCrMN?=
 =?us-ascii?Q?5eAzNTKUvYv6sQK0Vj8U8G6TAdGF/4pwWGYliJV/5b3UsvgZ8kBWlqBgj7dI?=
 =?us-ascii?Q?1ctMr7m1GM6U1PXzyCp/Q+TGOufNIVIUtCHvbcB3ACS7BGuWvgCc+g7/xfbb?=
 =?us-ascii?Q?UwGtL7hbk0ZX87GGUXfhot/Q8fzQrjYdVsjge3X7HJ2n+NRV5Twl4KYixnH8?=
 =?us-ascii?Q?LAcgONaMOM3LOJH2ALu/ezJNrNGiRKraDKhp/DVYWdSmGXXm88TkT+8idm/r?=
 =?us-ascii?Q?Znep6Qp9v6pjH6qENdQ8AycZwZSwKZfqAB2m73BuTSCAKvPApE8kr9NhVFV2?=
 =?us-ascii?Q?jkHOQDs4xKy5QW5bvj+tNVsCd8PZKIt15GajsRv5n6stlhWLvcjtl/pSoXS6?=
 =?us-ascii?Q?1De1Koux40UNUeJZxRlJuvXX?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ee46bf-b4dd-4be3-7b33-08d929bb63c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 13:51:45.7161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLZcbPN3tvbZ1P4GbHUzVwrv/jKothtMN/xHnqu9SlvF0Eq6heirx9s0QJUHBvVVFPNG0D4ZwVMplaMbGzYNnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
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

[AMD Official Use Only]

You can call psp_init_ta_microcode directly in sriov vf case so you don't need to initialize unnecessary psp firmware structures. 

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luo, Zhigang
Sent: Thursday, June 3, 2021 23:32
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

Yeah, it will also init psp sos and asd mircrocode. But I think it's harmless.

Thanks,
Zhigang

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: June 3, 2021 11:13 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

[AMD Official Use Only]

This one  doesn't looks apply to  XGMI TA  only , it's for whole PSP init , can  you double check it ? 


Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

need to load xgmi ta for arcturus and aldebaran sriov vf.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..6bd7e39c3e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -170,7 +170,8 @@ static int psp_sw_init(void *handle)
 	struct psp_context *psp = &adev->psp;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type == CHIP_ALDEBARAN) || (!amdgpu_sriov_vf(adev))) {
 		ret = psp_init_microcode(psp);
 		if (ret) {
 			DRM_ERROR("Failed to load psp firmware!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C36ad44d9dbca4d9ca2d408d926a4b1f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583311075104399%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tcFmUpgqBn0YW7B99DfjQl4cP4k7%2FHQGplQU0Zjj%2FGw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C36ad44d9dbca4d9ca2d408d926a4b1f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583311075104399%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tcFmUpgqBn0YW7B99DfjQl4cP4k7%2FHQGplQU0Zjj%2FGw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
