Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89406C54FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 06:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4735B2072D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 06:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2Tbs4s9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4735B2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC81E6E89D;
	Tue, 21 Apr 2020 06:50:02 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7196E89D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 06:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF5YGDyfnCuGzhIN7ljQqKgfeHBSfWEqkAW1EcGc79zPuq04zi4N6amD53WNiMXL21gQ+4S0cxmRqd+zrQSvzROVERTkvDytKtvg/2yv+0sRvFqKJc03Ezl7JfbQWpPxRJGTBHkskuH8vQUbhUlDK16dG5iJjse7/PvUOZw/UNDIjtMxxgvxqD4wX/vzCcTbbTX2bp+NqlwT0FQHMN/KfiRqpI4D5z7cNclPuEvUdthzVWqPNkqQH1co+Rv5g16Aa46FxWoxXMuqMh4uoAf3uct3N9ZgP4zMixs1Kjd9h4brswxX7tJNtBKILnsV8ayiEv/nSgUEWdSTOIkrHKgi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHkwmjdtqBMYhWs9C8CNsM363qNfBq6iS0qr6SPxaD4=;
 b=RVnfqzQ/ynCTzXHDQ1ByfHOXqC7U9XDqKpwvrA947eqRm3GeuwzCKTYzSZm//IcrRIS/O0j3GmoL/Wsv/f92jwJ04syut3ool0swufZ61LSuTuEzCE+VdYef4Fv2nn3mPJTCx0Dh9f2oZhfNSFRcw3XkaVQlcw6gpPsDzPnJN7l4SLkZD+mkdZO7Djc9BB0yap6v4AczECmJF3bjK+JXPdl9DFZJ8NK2zhXQebUBU4u89TzvJ0hIBU7lfvk9kiyfUcE5nIiGrq5c5khyAN87scV10PLkrcMwkLDxN8bKJ1xxPwI5yTTovZc6pWBGRmBbR30OWEoXhgfRyF0+8JXdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHkwmjdtqBMYhWs9C8CNsM363qNfBq6iS0qr6SPxaD4=;
 b=2Tbs4s9lXMjzAVEiyYrjnkfKfICkSuAVVww04d8NNkpv0CJVIj/G8HU4k6gQHMDoJ00GMs/BSOIEkavU6yVYbWkjQNphr0kvAojRWDytfORRzSDUOPL3SIz7WVUqIOlzz158GNNr1jJkYwOzvw5SSFEyincMTuyo/Lx7R2niJ38=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3632.namprd12.prod.outlook.com (2603:10b6:208:c1::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 06:49:58 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 06:49:57 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/8] psp code clean up
Thread-Topic: [PATCH 0/8] psp code clean up
Thread-Index: AQHWFvzUJFSvyjamj06Q9xF3ek9kPKiB+BYAgAEr9MA=
Date: Tue, 21 Apr 2020 06:49:57 +0000
Message-ID: <MN2PR12MB4032DC59EAF40AEF3F54D536FBD50@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
 <CY4PR12MB1287D4C4130984392E5072B9F1D40@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287D4C4130984392E5072B9F1D40@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-20T12:55:32Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5ae8d023-9958-4f32-ba6e-0000b34f57c1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-21T06:49:55Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 47183557-1d64-4726-b9d8-00006a43baf9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d0e8b84-6ed5-4506-1d75-08d7e5c034c7
x-ms-traffictypediagnostic: MN2PR12MB3632:|MN2PR12MB3632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3632AB80D27FA7081AF28C11FBD50@MN2PR12MB3632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(53546011)(478600001)(7696005)(5660300002)(86362001)(6506007)(110136005)(66476007)(186003)(76116006)(66446008)(64756008)(66556008)(33656002)(52536014)(316002)(66946007)(2906002)(71200400001)(6636002)(8936002)(26005)(55016002)(8676002)(9686003)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zeuF84sSVLBN++6ZqvTPRYez7t1PzIhq7bseN+b66IuTUm2gtuwfUHOjF72IFQxqJyS774HNx0sdKrdsw34XaeW4TuhpsFWkj3ETpQR/cjBOtIrhuQaPz95ONOg4OwjQktTW4oT2FnlpQFtC6IOan7i5DvgqpHndmraad4fdGMASrHSt0jkea7qEt3t+gf21Z3pWwv210ptLQ7YFn4mxmg8CcOj/A2mABd4PaHVD/sd0D99xCEJNXlvH4FoSTxGf6vpu9T3hLFJ5RJdfgNYQTyxN4zobu8WV4GPZy4Ou6wdeW8gKjIzl7UebrvpRj/KGr7XadVAWdzVcaUSOqj0QYprZjY77aoHfV1tO0FBDJgWgun+aqVo2XzHG5b1wZjOwQ7FvkPmUYtQlj6hAixqWQX4yRGeGPRbevGe04V5dQyOl6hlT3Ejg/THCu1crTu0R
x-ms-exchange-antispam-messagedata: gp0eyklAA39RKWyedXpHpWGqm+tgqwbN5xtOJW6ndveAYvYmUZt+AphXBLIWRKdk19ZufNS7kErPEqNAoYzOr9jakdn6jHtTv0NcaobqOoRrNpAnOxZvunkk7Cbg0R2DzOYetJJFk6/+HwSnRm7C3Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0e8b84-6ed5-4506-1d75-08d7e5c034c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 06:49:57.6241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFF+VntK2vpEh79ImCmF+zbRK84pN264JVPhXv82K6aWD9l7UEyDhzeQqC8tDB05x1ShO6B1ayhTKngjpHTUBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3632
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

[AMD Public Use]

The series is: Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, April 20, 2020 8:56 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH 0/8] psp code clean up

[AMD Public Use]

The series is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, April 20, 2020 6:17 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 0/8] psp code clean up

the seires make cleanup in current software psp support, including:
1). retire unnecessary ip callback function like support_vmr_ring, check_fw_loading.
2). remove unnecessary tOS version check 3). create common helper functions to avoid duplicate code per IP generation

Hawking Zhang (8):
  drm/amdgpu: retire support_vmr_ring interface
  drm/amdgpu: remove unnecessary tOS version check
  drm/amdgpu: retire unused check_fw_loading status
  drm/amdgpu: add helper function to init asd ucode
  drm/amdgpu: switch to helper function to init asd ucode
  drm/amdgpu: add helper function to init sos ucode
  drm/amdgpu: switch to helper function to init sos ucode
  drm/amdgpu: retire legacy vega10 sos version check

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 130 ++++++++++++----  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  14 +-  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 141 +----------------  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 235 ++--------------------------  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c  | 172 +--------------------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 262 +++-----------------------------
 6 files changed, 149 insertions(+), 805 deletions(-)

--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
