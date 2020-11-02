Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE9C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 01:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7782224E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 01:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3fAYgSNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7782224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10CB6E21D;
	Mon,  2 Nov 2020 01:56:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CC56E21D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 01:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHXTnAz3occFP2GXCM6uP87o9grtdBzc+kZ7nvXSN1/mtZPdYLdpbkZqTatvkYeuV2igtBgu+ICl0Zo6ktQPgzahI5voqrtRa7c5AWfnriwreYzB1IN3ar77yPl8Qbsg0CwVexUB1ToBDlON2EeKpfyXa3iPbXozScj1cOynj7aq1px+OwkgTcyNdQ1wyk42pWfyAZO4dZ6ojX5LJ0GRxVtfX0RAOUisEzSyiYG4l6LZwWI3KaNHD7YByXFMIRqzdmlvjLrP0P918OQDN5qq9bI8/A5ELrpc2Sk1/mwkhYkv4CBjH4rVXZuZ16zNZavBKK/E3aTuTE44H6anqCgqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rErTt8C1Buj7aluXqZdkGEvLVn0JU2fCX7Qaud/hXLc=;
 b=Zm7cbD3fs24tzls+pBhCjTE1mzb3OVezBnGdLPhoTfq+BfFA7dN8bYK+X7yRoq7FGNDsljwsi9lJv13qoA6wTfJ9BrUTsCigoyWouwf5gDDDfQMU9hqy0Rc/U90QpBWJN/lBxZTnaK9Ce8zjoVOeebdZGcp8nPvdMIo4m3bG6ifj8WljxmiqQ5sc1gZOPtDEGtxNTQ3o7pbUsNrkM4Kr8IrS106aR+NQvJYoc3lGKj1M2tpD7WQwDb3/nLhX6G9h2C3Ja0mRE3aws9s9sL5Yn9GboVh6RkiBUnu4Rx0FrgffQuRF4RsAwAO9wurVSOYXBMLy1oT4x0O5T1Pzpuixkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rErTt8C1Buj7aluXqZdkGEvLVn0JU2fCX7Qaud/hXLc=;
 b=3fAYgSNHoDEks7BJoNsRaqWxFKqZa2YMmK578puLzDN6YuKlqXNHxsyTgbOkibddKnCogaNfhH1XTWpcHsIk/Uzx3opmT+9wzE2k+oqG3EsmmzvUV99GUcUyeFtdvIjqiYDutn3PgNoVestxPnNTxkAWYVz374pwEXsFs9vtzFk=
Received: from BN6PR12MB1425.namprd12.prod.outlook.com (2603:10b6:404:1f::19)
 by BN7PR12MB2756.namprd12.prod.outlook.com (2603:10b6:408:29::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 01:56:50 +0000
Received: from BN6PR12MB1425.namprd12.prod.outlook.com
 ([fe80::38d1:aeb8:764d:c2af]) by BN6PR12MB1425.namprd12.prod.outlook.com
 ([fe80::38d1:aeb8:764d:c2af%12]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 01:56:50 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: allow TMZ on vangogh
Thread-Topic: [PATCH] drm/amdgpu: allow TMZ on vangogh
Thread-Index: AQHWrjKIrweYyJnCaECNfEFNA+baf6m0GjoQ
Date: Mon, 2 Nov 2020 01:56:50 +0000
Message-ID: <BN6PR12MB1425808AE7ABBAC0BCD79901F0100@BN6PR12MB1425.namprd12.prod.outlook.com>
References: <20201029203133.215585-1-alexander.deucher@amd.com>
In-Reply-To: <20201029203133.215585-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-02T01:56:23Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3e9ba6bd-f823-4fcd-b1b9-0000bc916844;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-02T01:56:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ed9984cd-0469-4052-bad0-00008a44c273
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f01b6daf-9c95-458b-07f7-08d87ed2906a
x-ms-traffictypediagnostic: BN7PR12MB2756:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB27563D8137846BAAD5DC57DAF0100@BN7PR12MB2756.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CLclPtFZtAqr9G7lDyg4BVyogF046P3jYyzSnbyZNnM9EtyD4OCI8HLHs3+eLpOSni1f69iH12LdntgHbkemTePVwVh3ht8g9CRtFq2Nf5uk+t2FxThuUxp+SPNmuMvM6ZN6LR3l0DaPVXZl81BES0Dlj1JRIjascv0sEzhlHLpOqe2dAa9IsYRYJTOGT/DwT2m5u6ulkRvQjN3PkkPEVe/n680C2nmKEU2DjIzKC/r/JtjWE8x4NUb10NaWmPyMQ5N9D+sBF7BRjKvZZun2twgFwXV+5qshQ6TnlVQsVVmmd8Xsjh2Bva8fQ+DMg02iH9eoQXDk1xPtlqUXfYjAWl+wnOs+kiD2WkaBJTO6gM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(45080400002)(26005)(6506007)(53546011)(71200400001)(76116006)(186003)(110136005)(316002)(7696005)(966005)(83380400001)(478600001)(8676002)(9686003)(8936002)(5660300002)(66446008)(64756008)(52536014)(66476007)(55016002)(66946007)(4326008)(33656002)(66556008)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JDXsscYs1ApQCuYFPT0IvTziUNFXsScWZohK6eCcgVVFX8lHXe1jksv9uEhHFAnczhEOt97S+POk6tPM8p8ZWz+IzwGc5B5UxxYq7ylcifqj8BtxkoX1RqUqsz4YeB32S8deeNwVDbTDnFJ51OvL6zCDeqLU003yeJDuG6z3IgW74DdkiYgIJXcxFh/mU1Vd1GaUDJk+/zAa0Rr3gzZuWlrykNbx9auLZHVHNE3QhgVdn8vLZXvP3JeqxGeDTnNZMmnHCFdXBbEqCmDVc3lG2o0YH2GoEMJnI5glf6v3cYU4y4udTYxsS4XqteKQwGlpQpKu8Dm2O/mC3NuqcJuusilcLrcSOIUJL/tf6XCuQ1w0k2ja9Ib1W4oigERALCWqUKmr4HyvVKBcYLLQ6s5zbRU44zCkkkqFy4nOqCzXUh8BAC3YBpaohSreyxYe1IXrNgz2VXwtWxdUt+wsKe6NzdDucJqqFTN1s8/U/MVTYo3A8seLm0gr6pLEakUcCFwQVgvs3nYvbmFEE1UV8ykTLJxqyHIytQUgcx4YPF4uB72wR0rlWBNGtYN/BJ2VGof0jPZu3pshEO2OZpMKL+wRZH6l5trqi0kGbU5PtNYQ3mSGioIopVHLK5WNrQhXfACH9egyMx+FeXL/yOf4X84kHw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01b6daf-9c95-458b-07f7-08d87ed2906a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 01:56:50.2185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+DTcJUvw1JbUu1XGTCEaYtHXRlbB615OJ54bMX5G7NXqHz2sUtCAtv4D1TA6eIr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2756
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, October 30, 2020 4:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: allow TMZ on vangogh

Uses the same pathes as navi.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index fa799600a58f..1449489cbe78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -393,6 +393,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_VANGOGH:
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Caaron.liu%40amd.com%7C82d0483b13524710b29108d87c49a8c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637396003106457573%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=mB41tmZeWCKW7i0%2BBCQPLHkGU39%2FIldbjcrt8kfYt7Y%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
