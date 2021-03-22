Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32712C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 06:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75766191F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 06:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75766191F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCCC6E0AF;
	Mon, 22 Mar 2021 06:13:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A43C6E0AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 06:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBQ1Y9PVMphaF5apAMz7IZHc2M6hVgYub4TAuC5+uFTiU+9zMmnuwDcN/R5pmg8piONvv/GQR9TuomeOvFKEs+OKwiXNsd4R8YU7oOrkPjiljCazsNC7Mkw1W3UROCmzygmjGY9h0pJMIBJc+02aOqg8kp2aaJ42bV8b6mJHV8HYHCI08+asNUFXRaA0G6e/+WcJiucXjJ9rs4yFo9G6PCA5zhiDlN+UYDVlo2ZrJV6ULwZ7o5f8vvo0LVONgu4sssXFc4HsHyueFXfpxeOb/KhemUVBqE6NpDPs6wVjyQU+9dSAPLf01QKW50eVVrVWfptaRxNeaSmz49oKCY/h/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2N+FWAOL7fRPHYZeFYROoLVJZAJKX8boX3iaV9BQ+Q=;
 b=XKokNx80IZkf2gqqS77bDhX7aI8Zc+ItY/Tf1yu5cWzg+cl2+xbTQpQVFf1H1SjqzVS2bHb1o1/bsxtpM6fzNhqnBHdIJ/lfVVKZ0z8H6qGjhVfiVYpUv5nVXFhb7aiYZpplbcyXmHIlU0A1rKzOD65psQZOyRRIsFTRj0/BmJXprSOcE4MteaakZaTv7t4jIVd/Rc6LMKtQJPdRfsrbxtJHKumWadbdbYCCCmw8/XrrU/hFrQGNcW5vtcX9aJTLzxRN/cobBCtU9JFBTfDUg5JOlZxfSH3p2Bg6Al45ptTU29Q9puvqYLhz1DfUHqAWLKgaADcY/Jujhlb5rg8scQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2N+FWAOL7fRPHYZeFYROoLVJZAJKX8boX3iaV9BQ+Q=;
 b=j3qK4OqTAAu+GFigoo6KHh6fEqDgAWiDZfN3yy9C7ZCNKoEaJtZF7xzFs5RCWPHdKOmKFyXAtTdDwJdxZwm0wEhduPH1yxQr5vGFDjObndDEVXFxeJziieMBOTvLS0q5RBBkUwrCWYAS6ivjgkLWSg1gexvakJdTSs8t/o5XSBw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 22 Mar 2021 06:13:14 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686%5]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 06:13:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 0/8] Add mode2 reset support for aldebaran
Thread-Topic: [PATCH v2 0/8] Add mode2 reset support for aldebaran
Thread-Index: Adce31/4KuLMVGQgR/K1fu1T4rIRdgAAeBSQ
Date: Mon, 22 Mar 2021 06:13:13 +0000
Message-ID: <DM6PR12MB4075B499DC827EA912971582FC659@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB45490FA91C151ACEAA0D88C797659@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45490FA91C151ACEAA0D88C797659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T06:13:09Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e349814e-87ec-4ade-9d22-3e96bab52ea7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bc24377-4b8f-45e7-3b36-08d8ecf99392
x-ms-traffictypediagnostic: DM6PR12MB4433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4433D248321AA4044FFD1909FC659@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJhSuWsBHojopKSd8+nkcUu6Bm9cfcLZWsEjz/5kF+s0UBe22Hijg6MjbXh6nmODLomm40xlCynw+DLepKjCUQ2V3D1wq21rOiFXRHVRJpNXa2m4Ov3xsrxJAPyCeVIZDCGscFNnTsIK1dhY34ifI+Z2DxqCihv1Manek1LlJVZN2DXPrF1+ATCwqL/V0kQPnZBKQHF51BU4PM/1eZucC8RVUx0XrC/DQfhqkPakMpNfrJEWFpVPxH2rZPxd+7u2vUxPpwAqc3DfJuQ5N2u5y1xTZ+ShEM7zNrO9TuJ0MCY9MhK0TrA3EeEMVJO16bcp2MbOtGNzc4o3HyVfo+A1v7/8DKYmeFaxIILy/qJAR3z5tJOex9fcqtmyAsL+zbNYjxHp7+HoMxymlk1oZK2HMmcVAM45BBum2P4US+CzxBL+ra82SJCqkqC/GJG0zP3zTt07kNKVyzFnA9spiv5dv+hRyzl8CoU1/Ul4KaSgS95EsmRA1LChtjKRrJzgCuSHHCOWPFKaCmnZE9rXP4NafU8qC4GMgWJniiSMGRG+eWMlTbGnbFmK1ivy18qo8aPl17/aR4VFMuEQem4RHS323VTPL1uaqAbDqUM67EndMxQUuNghvyoiWjopDak1/Vqx2tAHoXhS5Y0RlvcBWFKLDcFZMWsHY9RtYzdodVFH+vM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(76116006)(38100700001)(66946007)(66446008)(66556008)(64756008)(110136005)(52536014)(316002)(86362001)(2906002)(5660300002)(478600001)(4326008)(8936002)(71200400001)(83380400001)(55016002)(26005)(9686003)(33656002)(186003)(8676002)(6506007)(53546011)(66476007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?X1UYlz1eVAyWG/mVodw7WP6Ncla83CeEcTSChnwgsabP8102+pZ44a0aR2Dk?=
 =?us-ascii?Q?53zsPge5wIM1djB+8aYfpKmDO1qEjGXEjgkObl85g0h8gB5Fx5At3rR9olAC?=
 =?us-ascii?Q?h1pI/1teEoXeWElrCWOnVJRA5HPt6pC+djCJOWUio5xMsm6gpG7rYjyOZvbn?=
 =?us-ascii?Q?54LfRTLc5p0JhKxFiLy3rh4lF/9wue1VvTa5kxLBh98RarYqgMvfT+Z23X8S?=
 =?us-ascii?Q?C73GbRCsvHQCvGJINS0mt4KUCnVG1clXBDKyF+1c1P6DjXefpyVyoKP0Gav1?=
 =?us-ascii?Q?BQKR/YUwKcx9YI79bGub3yuFipn9VpzhaHsqtfbgBp1y3q4Prw0c5Hf11hZi?=
 =?us-ascii?Q?hiUJmwuMjsWAjfB8/UOInQk/b7Lm10suMi8v6l9i/wvxw7J4uQNfIYTCz47y?=
 =?us-ascii?Q?Ll9SaOYVKK3zF1RZQ8GhAm+jJ1fXakgcEVeEacbedIpE2eDJZSHboDtA0twM?=
 =?us-ascii?Q?VwWPXkTkbHS/fku3nipVI+84xcCq1vpISqtIimJqHcSfyBvrmMK79qZpLsrX?=
 =?us-ascii?Q?twGGhLBKaCH/Es4Mwijkwr0VqRcauX6L13TP83IcPantWPdHOlaopHklzp3t?=
 =?us-ascii?Q?/UUMQP2ZLEfB6znIUTuJi3qmU/mmyBg56ECi4psd0hYSad0QK+G5/EDWYOhR?=
 =?us-ascii?Q?Dt94urZBlvz8eqgxUycP2qxJTFpHU6ftoi5ZPB3x9oKz1o5UBW5V46XPA21e?=
 =?us-ascii?Q?UCoIUhuMRkIDPOewBSMv+6/WxqlF3fn7D9LnFmoPnXo3UdCa0xRJByDtjiCW?=
 =?us-ascii?Q?Ce3qbrAuY03GFnwqa1JBCocUri334LKxosM6fUBq5/t3YMfR4UyUkmOCjqWg?=
 =?us-ascii?Q?IMXTdQcbxMYXWz6KkvnuQiFkMpYWYEOttHl7y8aHbHeHNi4IqsnG8TawU6UD?=
 =?us-ascii?Q?+OQ5wcHEBHWmTqDpWZsa2Tt85JEPBj4UVH6sIZg/Pnm3gA3D5UU90jdMQvnz?=
 =?us-ascii?Q?jocrPhhbYajLDIrYbfzj0h1YBi5VoqR8iVpiyNmf+6bTcC1lPG3ZQh31oRIi?=
 =?us-ascii?Q?tN1aO+u56uRTAsM5KzyYKNg8+K/XSmYH7e4WhttnUR+nJFSFZ925LIO1GnCB?=
 =?us-ascii?Q?A2A9bJtVRGHD1FYzJfc1wSSH5N8g5dvC7xsWMDtiSRBe1v5pmbGA9iu1AeVS?=
 =?us-ascii?Q?72ZAZxKLvpDzaZj9wuC/OaEIzxuGWykEIsMGwrg4nUfWMcSKzx2tU/fd45sX?=
 =?us-ascii?Q?+VKTlvXNi4sU5xeE7lUO8VnDEesHjUF2fosYavCKpDxR7n1O1+/Nk1UURgsi?=
 =?us-ascii?Q?WgJpxLBIFaHYKrjTFgF0tRARq15qqc0ikaEEMbJQh7jPH0yP3FwaQGFa21K1?=
 =?us-ascii?Q?5FcxDBMibocYJwG8l9JQaCjD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc24377-4b8f-45e7-3b36-08d8ecf99392
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 06:13:13.8516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRWwCYZGcVp7Q36dErL2kD1PJ992+EbfNdymvEnM5t1fJQvPIluEz4wVarSH/fYKNgyFfMS6wIAGQZddXwPt5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Content-Type: multipart/mixed; boundary="===============0584923555=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0584923555==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075B499DC827EA912971582FC659DM6PR12MB4075namp_"

--_000_DM6PR12MB4075B499DC827EA912971582FC659DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, March 22, 2021 13:57
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH v2 0/8] Add mode2 reset support for aldebaran


[AMD Public Use]

This patch series adds support for mode2 reset for aldebaran. Since the
reset sequence is completely different from existing ones, it adds
supports using a new reset control method. The reset control and
handlers can be installed and handle specific types of resets.

v1:
1. Changes to the mode2 sequence as PCI space gets lost during the
sequence.
2. Add support to wait for specific events from PMFW. Reset complete is
considered as one such event.
3. Add support to wait for reset completion on aldebaran
4. Add a new reset control and reset handler method. Reset control can
be installed at device, hive or ip level. For now, it's done only at
device level
5. Add reset control mechanism to the current recover sequence.
6. Expose PSP function to load a list of firmwares
7. Expose CG/PG set functions for use outside of device
8. Add mode2 reset and restore sequences for aldebaran.

v2:
- Coding style fixes
- Mutex protection for new smu api (#2)
- Clear bus mastering before reset (#8)

Lijo Lazar (8):
  drm/amd/pm: Modify mode2 msg sequence on aldebaran
  drm/amd/pm: Add function to wait for smu events
  drm/amd/pm: Add support for reset completion on aldebaran
  drm/amdgpu: Add reset control to amdgpu_device
  drm/amdgpu: Add reset control handling to reset workflow
  drm/amdgpu: Add PSP public function to load a list of FWs
  drm/amdgpu: Make set PG/CG state functions public
  drm/amdgpu: Add mode2 reset support for aldebaran

drivers/gpu/drm/amd/amdgpu/Makefile           |   7 +-
drivers/gpu/drm/amd/amdgpu/aldebaran.c        | 380 ++++++++++++++++++
drivers/gpu/drm/amd/amdgpu/aldebaran.h        |  34 ++
drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  20 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  96 +++--
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  17 +
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   4 +
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  98 +++++
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c.ald |  98 +++++
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  87 ++++
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   8 +-
drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h  |   3 +-
drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  16 +-
drivers/gpu/drm/amd/pm/inc/smu_types.h        |   1 +
drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |   5 +
drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  14 +
.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  57 ++-
.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  42 +-
drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   2 +-
drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +
21 files changed, 956 insertions(+), 52 deletions(-)
create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran.c
create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran.h
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c.ald
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h

--
2.17.1


--_000_DM6PR12MB4075B499DC827EA912971582FC659DM6PR12MB4075namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Series is<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Monday, March 22, 2021 13:57<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 0/8] Add mode2 reset support for aldebaran<o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This patch series adds support for mode2 reset for a=
ldebaran. Since the<o:p></o:p></p>
<p class=3D"MsoNormal">reset sequence is completely different from existing=
 ones, it adds<o:p></o:p></p>
<p class=3D"MsoNormal">supports using a new reset control method. The reset=
 control and<o:p></o:p></p>
<p class=3D"MsoNormal">handlers can be installed and handle specific types =
of resets.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v1:<o:p></o:p></p>
<p class=3D"MsoNormal">1. Changes to the mode2 sequence as PCI space gets l=
ost during the<o:p></o:p></p>
<p class=3D"MsoNormal">sequence.<o:p></o:p></p>
<p class=3D"MsoNormal">2. Add support to wait for specific events from PMFW=
. Reset complete is<o:p></o:p></p>
<p class=3D"MsoNormal">considered as one such event.<o:p></o:p></p>
<p class=3D"MsoNormal">3. Add support to wait for reset completion on aldeb=
aran<o:p></o:p></p>
<p class=3D"MsoNormal">4. Add a new reset control and reset handler method.=
 Reset control can<o:p></o:p></p>
<p class=3D"MsoNormal">be installed at device, hive or ip level. For now, i=
t's done only at<o:p></o:p></p>
<p class=3D"MsoNormal">device level<o:p></o:p></p>
<p class=3D"MsoNormal">5. Add reset control mechanism to the current recove=
r sequence.<o:p></o:p></p>
<p class=3D"MsoNormal">6. Expose PSP function to load a list of firmwares<o=
:p></o:p></p>
<p class=3D"MsoNormal">7. Expose CG/PG set functions for use outside of dev=
ice<o:p></o:p></p>
<p class=3D"MsoNormal">8. Add mode2 reset and restore sequences for aldebar=
an.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v2:<o:p></o:p></p>
<p class=3D"MsoNormal">- Coding style fixes<o:p></o:p></p>
<p class=3D"MsoNormal">- Mutex protection for new smu api (#2)<o:p></o:p></=
p>
<p class=3D"MsoNormal">- Clear bus mastering before reset (#8)<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Lijo Lazar (8):<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amd/pm: Modify mode2 msg sequence on alde=
baran<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amd/pm: Add function to wait for smu even=
ts<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amd/pm: Add support for reset completion =
on aldebaran<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Add reset control to amdgpu_devic=
e<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Add reset control handling to res=
et workflow<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Add PSP public function to load a=
 list of FWs<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Make set PG/CG state functions pu=
blic<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Add mode2 reset support for aldeb=
aran<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 +-<o:p></o:p></=
p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 380 ++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 34 ++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbs=
p;&nbsp; |&nbsp; 96 +++--<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 98 +++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c.ald |&nbsp=
; 98 +++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 87 ++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h&nbsp; |=
&nbsp;&nbsp; 3 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 16 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/smu_types.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/smu_v13_0.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 14 +<o:p></o:p></p>
<p class=3D"MsoNormal">.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbs=
p;&nbsp; |&nbsp; 57 ++-<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbs=
p;&nbsp; |&nbsp; 42 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<o:p></o:p></p>
<p class=3D"MsoNormal">21 files changed, 956 insertions(+), 52 deletions(-)=
<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/aldeba=
ran.c<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/aldeba=
ran.h<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_reset.c<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_reset.c.ald<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_reset.h<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075B499DC827EA912971582FC659DM6PR12MB4075namp_--

--===============0584923555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0584923555==--
