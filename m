Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FEBC2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 03:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038DA2072D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 03:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xjFxaxwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038DA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9592389CD4;
	Tue, 14 Apr 2020 03:11:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D6889CD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 03:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaIj+ilHYmBRkyPQaDUusrQVWPRC4TANeYDvCSA1bOzEBV1fAR7AZuVbwYVRXSDAE7sesD3PswXkJs14insnU1E2DYGryV/96D7+8v0kQOVCfG6OFzGavMdBKSo9cWrgmiLzuze1PLOiJw7GEHMmpvyLKV4N8ylJJAtlg6RvadbVqvsi2w+rabaeUkH0WtSTcpW6+dpgA8hyALTZP8WFybZ9y9YnEXivNTELnjP2zI//ThCVX/Uazh/wPTS4mcVFx8QywGinWbtcySZz7woUH6TZXWF0VM3Voz71Qxv4JAr/gX2z1LrORBPKyFFhJnlhLry/aVlXur72cq/ELtLxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrLJ6qc21/ajL/dC/EiP6cipZ5ThfgdWZjqYt4vMVPg=;
 b=FeAyJhCeN5b67l2+W3iB5ep8AH6fSg5CooMvuIJTyrPPiT5vaIgcNn5wA89OPx33DKIXM7fNe25BMIvurjTDZg5rdsfnaSS8oDvat0FO71rfcmtfv2LSoCZ5UTXwtWtJPt5lc2WvNT2h3jhdoANM049TZPPvjpwuW1HhvPM/DbHP7T7kpd8aGtRPj4xW0jyNJuqg0R4l/YKA+FECH+SepemzbaizTKRLn/3mocYweE4sLJoWdmH3ozn7yQrXBeWmJz1A1w4U5k+FCQOBlk07x5XF4nV0Ct9qbUaNWsYtEZ7FTLDylMHuCIBUNCaKru7knZUaa7j/teNWkckCvHnl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrLJ6qc21/ajL/dC/EiP6cipZ5ThfgdWZjqYt4vMVPg=;
 b=xjFxaxwb02LdU0pHmFBFz7pE2xLZD+HnOHEmddTfCY1r6MskaahmuNFSYrxX33YTrdPjunoCIjvaUk3MqrDh/Sgjj3fQJQlrZvCNMfXLS73dKyYVUIkKaByjcB7Hffb41+d/UQMU/Ris2Y/4RocukBy2or8yt7WoAHQiYsut+Go=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB3773.namprd12.prod.outlook.com (2603:10b6:208:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 03:11:29 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 03:11:29 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: bump the NAVI10 smu-driver if
 version
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: bump the NAVI10 smu-driver if
 version
Thread-Index: AQHWEXEcKNfAflWKzkmj+YcIRg4/k6h38d0A
Date: Tue, 14 Apr 2020 03:11:28 +0000
Message-ID: <MN2PR12MB3598B9A313C31F31E5F27C0F8EDA0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20200413085347.590-1-evan.quan@amd.com>
 <20200413085347.590-2-evan.quan@amd.com>
In-Reply-To: <20200413085347.590-2-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T03:11:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=655d20ff-8352-49c4-9060-00006795509f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T03:11:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e7859c6d-b93e-4d20-829a-0000e7ff26a9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [240e:e0:8f58:a400:eca4:7196:e5b9:a351]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad3ac3cc-2f98-4fcc-823d-08d7e0218673
x-ms-traffictypediagnostic: MN2PR12MB3773:|MN2PR12MB3773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3773B41368DD37539DB7D8AF8EDA0@MN2PR12MB3773.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(81156014)(8936002)(186003)(4326008)(86362001)(478600001)(55016002)(9686003)(7696005)(8676002)(2906002)(110136005)(316002)(66556008)(66476007)(66446008)(64756008)(71200400001)(53546011)(33656002)(6506007)(5660300002)(76116006)(66946007)(52536014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQt59HGXQN87WsKlK43lsmwVDncdztYVSu1uGrVk9784WQk84zIqmRONPE69XkzhYcgnmXHUOQaZAMbTH8WmB2mUOBaqrDZ4KnZfd16BClAcJqm+8oUfbaNKs3IBC/baSxIFCB3E4zYicevtm+bfgtIrruFj5vLivUSGeV3Yfw0W7jl7q7C+MqN3HEcbZwBpLFUgp8OvRjtr7by4l/1kM5I5IjpX8yLfvMZRAXebP1K+MaIirTRt6V5ByNoIKPsmuqg3tbAkorxduQ4ChKAh10cIIT9yMxPEAksVUuMMjQHy40R+4ws1VC5hYOTv5KvYLmc7pEambtYH6XPhes5yR6IL+Hugm/LSI6Cl8qp45OGTcBLmyBq6KK0MFDMK2JXZRYPBbtqr+psZTuHijetoI95Mn4fRwyfxnM0EEOEvqpEO1F9N2NU/pHVG5FqwrPkf
x-ms-exchange-antispam-messagedata: NePKHsWVre8Ko7Q9T92eCUwZNfXVv3uaGkD2+6rb4jnF5jSOSwOePO3+EGkWYXdIFgLuFT3VAjtWMzDuf+WJgg384TESim+QYldwKXeOTXIsQZ+OM02RZQp0Qw5PuqNityEDCEubMdbG1JO0zxok1nrTT2pgFNxpDo0xxuOBAPWHERhWg056B7JGQbuAW4a6LeNC7H3yO+s0ipNUXQKweQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3ac3cc-2f98-4fcc-823d-08d7e0218673
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 03:11:28.9094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96LFdEp4DLIhluoTDjPpRram9oRBeIf1bPLr3A4zMsyYUrnOaVZtzeitmCG0B1be
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3773
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, April 13, 2020 4:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/powerplay: bump the NAVI10 smu-driver if version

To fit the latest SMC firmware 42.53 and eliminate the warning on driver loading.

Change-Id: I3f524d03e53ec6778b7118ef72652a538eec4ace
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 674e426ed59b..e786d63b1e79 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -28,7 +28,7 @@
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF  #define SMU11_DRIVER_IF_VERSION_VG20 0x13  #define SMU11_DRIVER_IF_VERSION_ARCT 0x12 -#define SMU11_DRIVER_IF_VERSION_NV10 0x35
+#define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33  #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 
--
2.26.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
