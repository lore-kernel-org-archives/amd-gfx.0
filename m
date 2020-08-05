Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3EC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 03:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379A2206D4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 03:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pruKL/f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379A2206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D5089D2E;
	Wed,  5 Aug 2020 03:32:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0766389D2E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 03:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgkTWiK7bx6CUn16ChdiDiORcy+y8GB7Y9zY+e5m7yCl6WLxS92eyt4VvvFbWGN4dJwqovQyDlsGNVRPUWVcOlDFjZiwTRH+JsaX114KzSNmydoqQ5KnYQLqTHiJhGn3sN9D901lC9eyZI9qOUQ5H1L0XTKsgKjp1Ufb8bictb2cH2ZldGYVqM1tWGg9svQWBnQ+BG1rSYHk6pVVDLm4C6ntbbj7YbRwRIZycjRi8ZcMLXf3C++/5KHSiuVYrWT+DlYf0Kt1v115srp/4eYLDu/sK+kFPUtnxuUkSDqbZmvDxnU6AhxSpDcCgR5IYaLXSLFqWH9RGHqzFL4qLwfVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrQfE9LuEyOBkjal0K8092zOqbXGkEWdrTi2SWz7WcE=;
 b=T0bOy28xQh0mp/pKao9suZFAveUuNaZmMdEZddlONo9ZjYGxmhUms2vZI7jalUjzRcRYZmlaAsiaM4qcCCQUb8bGORQrMaz2hHrtDUFbiJtsistsUzF2+WK9KNOY/ngqVH43GvH0PYXYY/VtpMa61AZqXzoQ8J9zEBqIBHHhdWjfzkYW/GCjgFQ+e3vBJcrI80HK6AIQa5R9UqEYno4ms2sQzVTT4/Edmojvs/UOWZ5D9c6lEAXWESthy0HnubKc+R9fw8qbj0FKOiYsC/ny19PHBoBEpM1FudtVP/DUAlMsIG5mPR3YV7/JlTVKNdPdxVVourwPSue0UAnXdE0Ygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrQfE9LuEyOBkjal0K8092zOqbXGkEWdrTi2SWz7WcE=;
 b=pruKL/f24t1VBnBQdszsPOivBI0WPgceqmmFqZdIwmODz5fOH8XrMldW6AlskdfkEHYGBS9+uHOvNdB/BIfC2uPoyBvEvdczRgSNzWSubZtOZQ+jWQ6T0nPzIErlkJfmd+LziXDRqFOayOVxM/4/2OncBNiE4IvdesoU2tprdKU=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 5 Aug
 2020 03:32:02 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045%8]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 03:32:02 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: grant Arcturus softmin/max setting on
 latest PM firmware
Thread-Topic: [PATCH] drm/amd/powerplay: grant Arcturus softmin/max setting on
 latest PM firmware
Thread-Index: AQHWatgIfwmd6VnPP0miimpqI3k27qko3B7Q
Date: Wed, 5 Aug 2020 03:32:01 +0000
Message-ID: <MN2PR12MB4175BAFAB77F8BFDA66F645A8E4B0@MN2PR12MB4175.namprd12.prod.outlook.com>
References: <20200805032426.26924-1-evan.quan@amd.com>
In-Reply-To: <20200805032426.26924-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-05T03:31:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=641b2f3a-e0a9-4987-be57-0000507bd231;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-05T03:31:55Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c87b3848-51c0-4da7-9320-00002883d0d9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78ee821a-a6bf-4e4a-6ea8-08d838f01e1e
x-ms-traffictypediagnostic: MN2PR12MB4517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB451712F5A6BE4450623A03F48E4B0@MN2PR12MB4517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q5rIUJAwX45MEV/tEl9p/bexCUqCZIkZdb2r9/NXfn38ec8gjAZvWJ1OSgY/53QtMhGwBFqm3TpZuq5LpYpwX3q5ISNC7MIVQ6HLwNU4OUjolj22QREqqRlconp98MW+J/7QtF3H7qToN6LCXbdGJUd/U76X8YNIUfy1kzPj38YOvhZXcQU32opzJJN4v/Z9pB1vXN1fwCfPg/n9cFyUVmb3hCEE7Qv/4nfbcUh8xMJpbNK8dMye3cNQBobsbR78OD5kjMaYOb6QmhrqFgAKbw6oG9DT73Y6oJnIwK9VRB3aQrgK0aRNiX6NlbiVEIQH51cPbMk3bFROno/nwH0KPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(33656002)(26005)(4326008)(186003)(8676002)(110136005)(83380400001)(316002)(55016002)(5660300002)(66946007)(86362001)(76116006)(9686003)(2906002)(52536014)(6506007)(478600001)(8936002)(53546011)(66556008)(66446008)(64756008)(71200400001)(66476007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: xri+FR8OPaWx7cFMaABGqIRTQ0CB1Mg58kukaKMgPSfoDK+JiT2TY1EtkZvL6QIibjsbvJXmLQlN6Z7Rvn7w27zuMBrFUyqK2q3VMgPA7Tskc3H+aj8QWNNABQOjXroDZ+rLzZI2cCvMm1EFumDRLhv9iLCHrygV94S08up5RP9gYIAae/IDCfCsr2RaizlXihy1nCdQ/Ch+LZd3+QTGbnSueyJXcwhzhhwFE2N9mn28h2KDFp8FQv8Iw8uEFIXciNSKmKDN/K36UOsXfBzWc8N+bVvlv0SDwm7vzT3l7oxrp21vCsCDYp5ZduLIvtNkID8asdj6nBssV5c+HR0PvqE6kgXwr0arJr7ppXHvwDGFOfB1ecLEtnEMNhUgEkUfzLHFuq+akP4l25te5ct6GK6vTBU8w9TUWTMDeE4hANvQE4xDsdVjBW/nUYRS3X7jGSHY2cmYJcQcpQ+k1eZrzgcfG6njbnUDSHWU6YIJ8xvIYxECd4+0F7Z2+lYLSfW3mJLmI7esqUWLLyYed4B3FGv0sMVxMVQSFtcuceGs2UoG6C6cBsEUktz8fS8POwvIlM77SAhZpZyxSRuEL95Uu5cwZUFOTMvEXsGRnz7W5LZbbuhgkMHqw546YlqcFvUfdvv/AUR9QWdziPTXMVfuiw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ee821a-a6bf-4e4a-6ea8-08d838f01e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 03:32:01.9571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8vXznBtm5+ocUwBSCN1ygbdDlr3Cvt+a/0JtE9HNG2eqe0ILimMqyyIbUw5dhMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
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
Sent: Wednesday, August 5, 2020 11:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: grant Arcturus softmin/max setting on latest PM firmware

For Arcturus, the softmin/max settings from driver are permitted on the
latest(54.26 later) SMU firmware. Thus enabling them in driver.

Change-Id: Iff9ac326610075aa7f61cb89c64d2c4128678755
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index a2ba6633fc21..73de3c013834 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -942,9 +942,10 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 		return ret;
 	}
 
-	if (smu_version >= 0x361200) {
+	if ((smu_version >= 0x361200) &&
+	    (smu_version <= 0x361a00)) {
 		dev_err(smu->adev->dev, "Forcing clock level is not supported with "
-		       "54.18 and onwards SMU firmwares\n");
+		       "54.18 - 54.26(included) SMU firmwares\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -1437,9 +1438,10 @@ static int arcturus_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		if (smu_version >= 0x361200) {
+		if ((smu_version >= 0x361200) &&
+		    (smu_version <= 0x361a00)) {
 			dev_err(smu->adev->dev, "Forcing clock level is not supported with "
-			       "54.18 and onwards SMU firmwares\n");
+			       "54.18 - 54.26(included) SMU firmwares\n");
 			return -EOPNOTSUPP;
 		}
 		break;
-- 
2.28.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
