Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8229EEDE9A4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 11:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AFA10E264;
	Thu, 14 Sep 2023 11:42:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A51810E264
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 11:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLVu9L8F1vgaB1YymhYlnqPlxfweeIFg0c6+j2oLBgNsvtw107xufRaTHcP+73/zYH1Fhs+zqaCN8Pjd6WJxjo6vr/0S4exKR351nD6MC3Yv5Dd1ijvl9XLry4Zp6/wKeaQhWJu4owmhRH2Y+I55oN5VTbWj+lxxlHvqz7edB+PyQc0i2qeqPI3Wwy40qR/d8l0k2LVoldJn0XnrPZY9/HDddOQrRsA1MYeLhjHW5Rrt7Bf/x1/ATia3Nd5+Bdk//pKe5vp2yp20uRrwtZITNrP2o90WoXKTXjvCmf1ND6e+4mKxP7Csptr9Uw1Coq4NGcc1EtmGlVdvWWz80pNCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RAVmszO3o0QKZ0cuvC7ry/uyhs9j1Ajaf5SlTqu7ow=;
 b=RPDbzFN+h51HgK6hYEsskMusbWryDVSNsOI3KWvIMxPqFKNYh5a47wM8yheP70/6fwsYWIHi0e12Qz/h34WMKy401aNzOj2o3tVEIktG2NVmRAI6HBXEEKUNrzJp8OetQhkFG9zo0Iu+n28xe1H5olMoh3kx95tBnR3jOIbkFG4NimJhUxdcm322kAaTnv8kTX2VcoVP35cVUnTbwTmRw6h3C//tRw3t8W5LLbh/TzPKIzc5MhdEiaDb+1o3B73bi8gfWa+sv/0sH13xvCmuha0leoYEeAU5Au83HjXIJPMEKE1FivCt2vx8NjZ4X+E1Fh2GrQis8mt8IFzg1V71oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RAVmszO3o0QKZ0cuvC7ry/uyhs9j1Ajaf5SlTqu7ow=;
 b=2Cvd+M74admWJsMoF7ieU+OL0EthZDrIqtzYM4ds0DUWlw2YdbNxPrdk0UQO5RoMAxkG2vp/mGbrC0NLILIfswquiydV26LXorrXRRNsYi8RR+4NPUz3xeEy3eTQtyTDHT4ICj078wbkJOfjWZii9CJMSYvpRW6UMx52pAR0DfE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 11:42:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::186c:dd6c:34f0:5632]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::186c:dd6c:34f0:5632%6]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 11:42:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix vbios version string search
Thread-Topic: [PATCH] drm/amdgpu: Fix vbios version string search
Thread-Index: AQHZ5u041egiNrxqc0qhYoBg37Gez7AaMvlw
Date: Thu, 14 Sep 2023 11:42:23 +0000
Message-ID: <BN9PR12MB52574BCE75154E6BF9952802FCF7A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230914092347.1233562-1-lijo.lazar@amd.com>
In-Reply-To: <20230914092347.1233562-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=49112715-164c-4bd9-b798-a46991d74fdc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-14T11:41:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7564:EE_
x-ms-office365-filtering-correlation-id: 83f9caf0-e683-47c3-154b-08dbb517a941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8e5HtKieeBFuEtz26ZQ4jiCJEmc4o/gQNXI3o/u+TbZ3ORdq9OxfkNave49lCYtw4pIbQMibI9RhsPZn5kmJVn50CC4xhV5xAMe4VNz3uURGV5ZJQ7yVNX97vqAalbEIH0ewIStIj3ht1FsD5XCE0flkGDGNJf7xBpAW6yCDNjLRuLKNL5L6BMyVewKPxaUgOHpDxUzY2EJH+zuJgrsMQO7LWqBgNk9yI9XV9SZLiBsmDtcxeZ6AUxQypAxftUd7bD6idrVjgCdtXLrTAv34JQKt7oLy/0tvUKTTv2HNJrEG+IH4fRhztsZv1gp2CZ2wJEvNvx9FQ40Pzb2l0brgCKtB1mTzaUW2Kvf90/3pttPzBSQb+bqI1fvtJOOLKpr6STc+xrWejrHLCnkYJwV+4tsRR0/H/EPx4Ln04A48yGzdiJzFT/sN7O5h0G9WWb4Pi8MUycsO5m9A/S1h/IlNFD929Ijs04uWnufYvCGB2Kkj7hDXbpFKxLisH/+W1l6YJXP7U5OImai8IF41BtfapTmyTh49EwIxgjDUKyfGXCS/osMmFTvCRjsS+FzUsPw7smcXwcrudvGFPvq480jQdU0I62V7PvNpd15QeA3qcWWr6uGDvK3WDMxosELhQKN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199024)(1800799009)(186009)(55016003)(9686003)(6506007)(66476007)(53546011)(7696005)(64756008)(122000001)(26005)(5660300002)(41300700001)(66446008)(76116006)(66556008)(52536014)(316002)(4326008)(38070700005)(38100700002)(8936002)(110136005)(478600001)(8676002)(66946007)(83380400001)(71200400001)(2906002)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qV7owtk+FOVhJM0ZguQhDxXfXY3CjEf5YUiY+r7s/VCHwwAXKiC9WwjrPRJW?=
 =?us-ascii?Q?amD/pimHynQGCFSFa2AmVc64OSQczy7bx3ITW1vXrY+n3WFQveHo4Nka2TXV?=
 =?us-ascii?Q?ecXRyfvx/NBl0RgOdd+iEh1r6f7DVXx1yT86E/72R7R1vp821BfCiawDXzE3?=
 =?us-ascii?Q?3tAO2YTM/lmlYQUfin1jz40Ag8dHkfa9WAHjalax7FbeXAuQTyFh3MLq9wGv?=
 =?us-ascii?Q?UK74gZQtfnB2OP3GJ84221L/vpllkOTCBI0EO+1ync03U+rX5uxmQIbsO3A8?=
 =?us-ascii?Q?IvYewzB3QVYmf/3/x49f5lsCZGPr3HSJsE8El5NcxLYYYVl3zlmIRDe6nRNp?=
 =?us-ascii?Q?Ykj3q6g275MuAD07nPwdsMVWaChOHn2/vHVf8KaPemPnD+cpOwVtWUPJ4L0B?=
 =?us-ascii?Q?HAJqChkbo8VGC/ubh3bQCN/6PUWxXwuW2hlggzHSmFgoBE49CGd9pRfgwkCl?=
 =?us-ascii?Q?MC2EQhabla8rDnj0YHhjwhNhbWY88QRFYgS7uoNzq9nhqbYh2ng0NHiuEadx?=
 =?us-ascii?Q?lodmxgRzOLCf9mgFoxBSxsOpO0hcUvolCnFma04xRRoK4+N4qFVv/g8WM5t/?=
 =?us-ascii?Q?N3SltVpkiJL2JtBvIWwGNj3OXd9rMmCOH2ybkytLZSPF7np+VaPjXaH65Q8U?=
 =?us-ascii?Q?xJhRj3iCAgXWf5tELc4RwvpHfeyHe0lyftacUYOEJ0rXeFx87MlBv97Z8zXG?=
 =?us-ascii?Q?FprqERB6zZOsdJs8HAkTzdZMma0jMUx+6RHHlWzldru7ekQXbVF8NR806R1+?=
 =?us-ascii?Q?HxXVM9KB7qF2GPEg/Jm7uy20EMzRTd0k83gyEp0jEvkFZ3oqDociWvkliCRY?=
 =?us-ascii?Q?0J2egi66twKh/aWc5nxRNU4f01gZS47ojoZwdVEU23XGIUsb5wXbWS/qBtEK?=
 =?us-ascii?Q?uv4/xPEuwSZOXBdnhy5DYITZysORhcAu/GPnUk9izaODb0FL92ddi8bDcnmp?=
 =?us-ascii?Q?YVv2GrZ7d9S5fsMz/G0A1UUANXNMjlO+TIyM1jokOZGCDzs66oxq6ri/bO1i?=
 =?us-ascii?Q?mY2hVJQWnidzpdYKF0ysIP3mn0xMFfs8D59tOoSxiz2iX7KF7/qq5lPBh4mQ?=
 =?us-ascii?Q?NCl8/aYc/f6e2eC/3VwnN5fk0ZjUoA//VbzpISll0XAUA1BylAGI0UdbCuCP?=
 =?us-ascii?Q?3NpmDr+g4xKe1u43FT75BTXI2EyBAZD/xZGKBMdjbtSlboa9PBrs3W6YZ23K?=
 =?us-ascii?Q?GvDUbqsZCZWFc83axChXwhrFcDQbzF5HT+lIyYEDX3TGSC1jnmBX33SbJDgy?=
 =?us-ascii?Q?DdU7xi6WWM5llpFXSf9BEObWMaZjL1bKZapnHYcszK6hT9ZL+RRAESrXHQLQ?=
 =?us-ascii?Q?y+WtzxvCUby2KhjVTLTUM27ehnUhv08T/5m+z/TAax/+IXPqUr3aFTQJczwF?=
 =?us-ascii?Q?RySU1EjiraXnt8GsTiXHewwcM2ERijGnWCZ8XYnJRo93RDHzyMdpAI3tTl13?=
 =?us-ascii?Q?vkDUYr1sPYlamM/vB6JhNTa0sjxv21XT4FhgCz7fdPKUYCoPNCskprSSBY+m?=
 =?us-ascii?Q?IvR1DfXv4tFB/GXClD8QHBeYOH4fFvJad62fuPJSvl8xHtH/3n6brB5y0ZJN?=
 =?us-ascii?Q?leWepZkDvgUssXMY6V4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f9caf0-e683-47c3-154b-08dbb517a941
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 11:42:23.1328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rTpKCLpTm2QonqVRpJ4rADPq9/S2ikCMOwJvIkzk9GsNWItip5hbfNMHH0Dr7dZ27YnOW52RhL1JNGwd1R4zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, September 14, 2023 17:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix vbios version string search

Search for vbios version string in STRING_OFFSET-ATOM_ROM_HEADER region fir=
st. If those offsets are not populated, use the hardcoded region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c
index 9f63ddb89b75..2c221000782c 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1444,10 +1444,27 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)

 static void atom_get_vbios_version(struct atom_context *ctx)  {
+       unsigned short start =3D 3, end;
        unsigned char *vbios_ver;
+       unsigned char *p_rom;
+
+       p_rom =3D ctx->bios;
+       /* Search from strings offset if it's present */
+       start =3D *(unsigned short *)(p_rom +
+                                   OFFSET_TO_GET_ATOMBIOS_STRING_START);
+
+       /* Search till atom rom header start point */
+       end =3D *(unsigned short *)(p_rom + OFFSET_TO_ATOM_ROM_HEADER_POINT=
ER);
+
+       /* Use hardcoded offsets, if the offsets are not populated */
+       if (end <=3D start) {
+               start =3D 3;
+               end =3D 1024;
+       }

        /* find anchor ATOMBIOSBK-AMD */
-       vbios_ver =3D atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 102=
4, 64);
+       vbios_ver =3D
+               atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, start, end, =
64);
        if (vbios_ver !=3D NULL) {
                /* skip ATOMBIOSBK-AMD VER */
                vbios_ver +=3D 18;
--
2.25.1

