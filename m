Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3BC47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76C36136E
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76C36136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957E66F49A;
	Thu,  3 Jun 2021 15:09:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B4A6F495
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZj7n83mHFOKiGoUhY4mQJlKDilIkiOzA6WdUAwnxlBngE2nlqq+/OA8QuK20cOtS1A2U5TklNYiutDFo/+nJD5kXEM5857PQ1VFIKZ3HkRt6yvxd8x55qz+8UcB2dyCbXB02TqncFmfrcXqOEu79rhXwaqXg0dJKC6HxSk0wSvhuVzhhassT7f0zYSry84MDtcTTjelD4dh6fx31cmEwehVwjIaXDLwfmdke+dDensrYwfAoNqpVhYTLTUHQP5g4JifSp1/W+dPBXncX4JdPP3teIksAoQiaeWdLhsPRnpK6qh19XAfGFsPGjTbJepzCMnyKM16aGiocd0rrHTv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFQ4ZVeeigQL31S8pGHGscph0hrpImoVtMVRDKSkhvY=;
 b=hk0yNLGMp8SbHtcKIhd/pbY4sB3KwbxHvTHk4uqgVRrxLaks/xWUlJC8GBSAXzQWxZ1BBtEF3DTr4Zz+iXoVcXRKGW6zSLejFoLPaJEV5/qaEMQyE6d9GhWpYhJgQ/EC6WNXZLGd9LfJAfr2+JSzQyqKxsWtVnyvC8BiXcQS8IVIYPapwRCtaoBt7g1B+FtKkGxaRj+0UPax9WynS3dDZB+k/7s6Hh1/rYJUn9LNbVh8ywPPIxnbHOp0s+547/+x6ZO7Shq4cJ576BBdJ9vEU84k3h1c7cDlmYqY7sM80CZzHkbIuyUajimkBMh7hsk6G9K12BxhW7xxx0qH9w+NRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFQ4ZVeeigQL31S8pGHGscph0hrpImoVtMVRDKSkhvY=;
 b=0otknxYclaFGiTUTIXTLLGzvGDD66y4ui0HWExgUk8zmeZtlKho7XnziuzIxr/JJe4Euba1QBmgSbXe6m89Ysp6tzhFhOQCFpMUPH0puI9VIIrXCdw2k7QThU6310shvIqk3d/S+95QKntV9sSJLfOWmMqS+U/aG8pZsvH3+8DA=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Thu, 3 Jun 2021 15:09:48 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 15:09:48 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
Thread-Topic: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
Thread-Index: AQHXWIKlewyG7iwtPU2qSP14xM+J/KsCY8gA
Date: Thu, 3 Jun 2021 15:09:47 +0000
Message-ID: <DM6PR12MB5534D815A3DBF82EBE78C576F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
In-Reply-To: <20210603141305.2542-1-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:09:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=dc0d67b5-4871-4759-98b2-407e1a34d35f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c20f2fdd-ef15-48eb-78ae-08d926a1a0e2
x-ms-traffictypediagnostic: DM4PR12MB5214:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB521412AEB177FBED2D75108CF43C9@DM4PR12MB5214.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BX7rL5Ru8feE2/BOpNApbbUtX+/LEf/uw7h0AqbMsRGMbvKTtu25ge6fFTZAbJj/wLem8J4PHRHXTxVD69sJZvtJ1uLoxydAYzxd7M5mB5SLW1MPpZX5dqixTaWGJnUBaVSg7GOwnIj7ZqinM2wbvu6ob0KDVgGFuZZmi3CSAzOwXsX0zPYCQ1j1QyP4emsxjixdl04VKPHJhyPVevZ5u8jjfRJ8s3a7c8yTNafcTDrf/uH5odwK1ZWbfOP3/KwZpMttVyZ9/IpVPkzQLke71+emf9DC1HlSVwnfFoxp+w45Y4W8aoSszDqQyYvMlHSeW1NwbTNT/gS+tBEpC3rNpTbpqqCniOWKkae64R5eBpWHkMT7TZ5mpUxsNARka4SvGjwhDD6MIokWPlUm8Depy1MHaE+bVMaNT3cExBy4T0Shm0RcwETwPBMDqnfk9zf96R70CgggGqBD45NV7sTATA1cvOJz78DZqCkhLnxKNgOsxEkpFpxGmbfLnh+Ctj8QsM3F9JqOiolmeOyinEHY14w7pu+dn5QGRbPvr65bfJD/zlq7qg99Hq/c/i+A6g47KdrQnT+XzpLgaUcrlJW9e5aDwE+OHDP252RlAkEZla95V9OTuzs7v+Z3jMWvsZQ3s4j3ZJUvdXfhhWweBsK84w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39830400003)(346002)(136003)(396003)(966005)(110136005)(478600001)(83380400001)(26005)(45080400002)(38100700002)(8676002)(316002)(122000001)(53546011)(33656002)(4326008)(8936002)(9686003)(66476007)(86362001)(6506007)(2906002)(76116006)(66946007)(5660300002)(52536014)(64756008)(71200400001)(7696005)(55016002)(66556008)(186003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BQQQSrOpzuMymsxdPfWSOpBC0algqPnA3SuxlVBSgfvxkqdf2PKSrBeA+mlQ?=
 =?us-ascii?Q?SeMgfAgodn10qZdI+e0BN7uF64No+mnNyczwtxeIZS/Nm0/XoNV+4vKs9M3i?=
 =?us-ascii?Q?siE0Pq6Ha36W1eCpWKJHWusj7YmcVvWkk70gnplGMWC+eMSaoPKemN+IvW2a?=
 =?us-ascii?Q?l7W8pmtIlu3z/gM4aeaVevlhdQ0f303k7kYPemQqlF/CpaiWz/9xsxgo3mwJ?=
 =?us-ascii?Q?K8PDwwxo+/QaBzHOUdGWFfoFJQO3B2TNW0DhTkUcD+Z3AQm11tXI4mYmfQ8r?=
 =?us-ascii?Q?O404nzaSkqSmHbWJjCKD0vuFSY6aahGA4V5+W4umvrTifNcCYko5zL+maGcW?=
 =?us-ascii?Q?uB1hzWII/sAIZdgKXQhKPVBDzLunsqANBE8ODhXPeYPjHuRCZBHVvqaB0QCP?=
 =?us-ascii?Q?gsFCHQ6KgALca6PvtKYONTFMZp6E/MR9/JP8Kdh/QOYo52XQA+8dtXtBcbpq?=
 =?us-ascii?Q?SVMXRP6zMOYPBNoz/WSc/jxaT84T/xw6ojaQVnVplRvZ9Oq6ZlIx8kK1PvKO?=
 =?us-ascii?Q?/1CtXO/KPzKf09WKxCSnPgbW173ousGVsYUhboiUfObt47O6TClit3/YQrPo?=
 =?us-ascii?Q?25XqkwiEwnwZrIir9x9YA4BmHIbg0iqlNJUaVEr/4AdMDcmd5aJJSQXHhJmt?=
 =?us-ascii?Q?csUjqru50OEEW3T9a87mkVDj2rGgKQ0WnICHybHIhAloOFwGqH99JUs2wg10?=
 =?us-ascii?Q?3LIK1dwAkbhOMHlPPmcVpBgf0gbtHj5GUsgxmYNUaQZjJyAYVG+gzzGhrmo5?=
 =?us-ascii?Q?+sg3eMar7TxUF7v34pK7u9GyWd6bl125u7/TMUYBvHfXhXua9SgDVlusHpix?=
 =?us-ascii?Q?sMA/zDE5rTyYnQPPmcdKQ1NYa/yASy4mJjKru1TZLinh0rg9DVrsG3JJNAaI?=
 =?us-ascii?Q?8PfgKfQjAcDrYO+2w2O11IySCLQLNW8aNKhGLAppLWgF9ZWmA5/HEU9R4JpE?=
 =?us-ascii?Q?1pEwrb+DPuypShFKFYyrqaDmFA6IgNxxkt5nvGmjeqNWxJrlePClbmH4vuml?=
 =?us-ascii?Q?vGYCNX8PqRmeNaRfY86KJ5thcTAoYvwXNd7nxlzemV7d44cJ2gbdGD2zITzJ?=
 =?us-ascii?Q?C1pJ5nfq++9Y7GOROF+HzqDGjutkiPgnq+JDjnhsebOs42GnSUKsgPymtaWE?=
 =?us-ascii?Q?K5HLCQKKMOkkYPQPwMfuGuHKPDl1jEDoyQPmKtWhAiZzH+r8lQ2435cHWrBR?=
 =?us-ascii?Q?ymLDvAs3nWapMupy1wBFYi59suFkdJCMiG3gErtsqUc6Xos9B5ly9e2fqCi7?=
 =?us-ascii?Q?5uRK/ybkEeZgoVxbQU2hnpsL7KQxJ1GzYT8QrTTk59kV43L4/1ghQdnIPrgo?=
 =?us-ascii?Q?gyMe2IzsHzUCPPnHq2X58sKp?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20f2fdd-ef15-48eb-78ae-08d926a1a0e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 15:09:47.9297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJ8UT7V/5aUsLWCA5GC0WMX0pf3bvAe8SJFDCg7SYu4Ne8xjQ5IwrlPz466szY/AsmduYR7XoSB1lcMLF7ow1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Looks ok to me . 

Reviewed-By : Shaoyun.liu <shaoyunl@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb location

host driver programmed fb location registers for vf, no need to check anymore.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ceb3968d8326..1c2d9fde9021 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1292,10 +1292,7 @@ static int gmc_v9_0_late_init(void *handle)  static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 					struct amdgpu_gmc *mc)
 {
-	u64 base = 0;
-
-	if (!amdgpu_sriov_vf(adev))
-		base = adev->mmhub.funcs->get_fb_location(adev);
+	u64 base = adev->mmhub.funcs->get_fb_location(adev);
 
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C6a01e479b7014508ce6c08d92699c71d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264179471370%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=C8qzQbKD2RJpQvNSWYvLlm4qgwWujhJW2c%2B%2FLhUwPE4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
