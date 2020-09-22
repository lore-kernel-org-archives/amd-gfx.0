Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FCCC4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 02:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D527B23A60
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 02:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C6bmXqPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D527B23A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAE16E5D5;
	Tue, 22 Sep 2020 02:11:49 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092CF6E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 02:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRw2vQkOblt1R751h/uAVTkJZPg78C4+S8dhm1RUlTgyrUoeqEUmQIOYSgTQut0v7bW42qV5KxjBpsnNy+fqaSb/iifIGfbPmggCnDJzgy+1AsK+JGxxBqLddO6ACpdhem4CEC5xNuf9evzZI2p4t+YQG3fl6phov5Eq4HcjWVCKqX7E7/iTc03g5m8L2ouj1EHb08TXv1q7qfHbaH1IdmanIXdaDBHlLxQVhSVVMoHBaTFWpTybDD+zJsgEaCZc92vLZhEXsrvO2K0aHonljxWiXy+sqlEOgTcf7OYcKWCJgkG93Gi8oYr3VaDW5K4MtbdHFqMTrH1NKoJhXRXTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFd+EaUeGjWfE7XwKgPUTG56QS2wFP665rRyy5L36IY=;
 b=KLcuWn8MPuTgI0BUcVWkx7aNQFEKc2VcqXDgbwfINE4JG1cP8/mbLjWLyyhCO6BuFuWcaeNjGijsfi45AlRa1jub090yjUBfmn/eraEihno0GMPeqndUthRQMDFq9HWe0ytJE41in2N3POSC6OTlI4eK2Spx8AzjS7AQIpLvl1UiQuGiARQ/bBe5T6qkBZoVx/qE9RYL7SLNc3fsIDVhoX5cehz2W/6QAv89maHa3NeoSDUHjc6G/Lf5vuPf8flJvHumTgzAPdBcXfqLU7F1fLn7VPhRJBGSULWXFbQbiohyvroemN7Thxjcnw+a6p6L/lufsSySfCwja5YqQD883A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFd+EaUeGjWfE7XwKgPUTG56QS2wFP665rRyy5L36IY=;
 b=C6bmXqPFu9mxToeCtW6u5N91CA+FONkRZsQiGKmWmg+MwibQCASQuKX6mXzxHqe/0k1HyGvTfHtml8UUk57zdUYFzZDlHw+3KKXiw/bhkzQWwGYK0u3oVIv0PqIm4TP7gKO+ne4g24UBUvONH1GuTXqAZhjIojPhdNdQzoEebSI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Tue, 22 Sep 2020 02:11:46 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.025; Tue, 22 Sep 2020
 02:11:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue
 for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue
 for SRIOV
Thread-Index: AQHWkFl6bkMvA9qdxk6xKb0sMLkc2qlz6idg
Date: Tue, 22 Sep 2020 02:11:46 +0000
Message-ID: <DM6PR12MB40755ACA073B7A061A1D1550FC3B0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200921205440.13113-1-rohit.khaire@amd.com>
In-Reply-To: <20200921205440.13113-1-rohit.khaire@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T02:11:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=71ac5910-d5ab-46ee-8e29-0000c69e362f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-22T02:11:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2edf87ab-699a-4c01-8bbc-00009b00fa2c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T02:11:43Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8a5c3fc6-f707-42f3-81b2-0000b52c8473
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45c04a7c-6e4b-468e-0fdb-08d85e9cdb97
x-ms-traffictypediagnostic: DM6PR12MB4435:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB443527AA457418BCEC36DFF2FC3B0@DM6PR12MB4435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZU04X86zQmMdoBOvPugW0daFLhC00MvY5MmGU3ZtqfVBR2Y6EVlesS1XHHEFJIW3tUJZLSTIst4bwQj1qZ1owt1zFFow+eU3oCFb0+3vle6i+ZAKy/c4/qVZctHbUt1MFsbgdh1Dpl2+UreTG+0zrDUNUfhEVYNQmgHbkyRGOEFyfIfpYkrb/SnL8964+dXA5ZNpBU4UnsSvXnnH2YJ2/F0+UpF+brLk2r8A3EMr4YWP/9YIUdTNHZmNUfJ3PKRK8pzbbwSgl04D2ViP6RsIyETaLgH1U/DLRLq6IcOvSk/Q4+//GXZJoIq3mpmSDMVfVvtzEQYYaC79stc9hXv4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(55016002)(2906002)(53546011)(6506007)(86362001)(7696005)(76116006)(66946007)(4326008)(66476007)(71200400001)(66556008)(66446008)(54906003)(64756008)(52536014)(5660300002)(8936002)(26005)(33656002)(110136005)(9686003)(83380400001)(8676002)(316002)(6636002)(186003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: k1qXtnvtzMJCKOohoFpv3gmCjO/xiXxe4JakpLfvQc72UdJDcr4ZqyE3LEST7SEpUfCw07f/nnflPv0fzmp2pudfxbot+q2mqGw/QB2lamAIIy21k7i+fhfgSojpDcVkcDOjlZlRS648JQHkmlF6Z4BGDso+ooV6ydhK0FC/EzIm3lYwVN4oNdJ+mhBnENlv3jNsAnK/NkKxmvMfgd47JjIfgWwlABQKAhUf2CIwMhr0ILwBkby7HLyj14cawyD6x8cFFtsIvKNu835MpYd5j1u0hUqKTXQ6wnFPDLgFTRN4Sky4lyx8VaIA60CMEf0yAg6zzmCCKzx2HBQNa25KK9l0C1XrkKFg2u104vDMn92jGJhL8Ay4O6g14Zyp8ltost9JeIyto49AzWIm/+HryvwS3iRDvVuuREnTBbQhwMOkn9vKPJe5xG4HzX83fQiKhudxgZb+kC5V1y9g6IQGx8txs+s4oN4oc3gUra8TnZkgJcFzHB4/eQdMRcynUhnuplbbGk0Vawdvrvvdpf+v7aq7UemZvWxRoav+QrWdIKmw/LCQ2fU3wKL1C3aaCjA0fLIFK92CRaIPpKVbc2a5Nws/efKgCbrU80OeSx3STQK5Uk/mTyz1JBjTUexXVCm1O1CLl+8Y3gZBJCTgPY6rvg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c04a7c-6e4b-468e-0fdb-08d85e9cdb97
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 02:11:46.2953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf24qgGo0N6k4i4TikVmdNKinoCItKnDriUGtAhsxaZsIFWHIEozLBpNG3wHkkqQpprR3Hj7xgjHxdtHGfRDxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Li, Rong \(Zero\)" <Rong.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Min, Frank" <Frank.Min@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Yuan,
 Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

You shall by pass get_rev_id function call, instead of adding the check in the callback function.

For each hw generation, there could be several callback function implementation depending on whether the mmRCC_DEV0_EPF0_STRAP0 can be re-used.

It's error prone if we just take the change in specific callback. There is no guarantee people remember to add this check next time when working on the implementation.

Regards,
Hawking

-----Original Message-----
From: Khaire, Rohit <Rohit.Khaire@amd.com> 
Sent: Tuesday, September 22, 2020 04:55
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Li, Rong (Zero) <Rong.Li@amd.com>; Min, Frank <Frank.Min@amd.com>; Khaire, Rohit <Rohit.Khaire@amd.com>
Subject: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue for SRIOV

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7429f30398b9..4f611cd68940 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -51,8 +51,19 @@ static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)  {
-	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* workaround on rev_id for sriov
+		 * guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
+		 * as a consequence, the rev_id and external_rev_id are wrong.
+		 *
+		 * workaround it by using PCI revision id.
+		 */
+		return adev->pdev->revision;
+	}
 
+	tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
