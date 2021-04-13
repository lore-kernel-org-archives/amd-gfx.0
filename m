Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E01C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 14:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63735613B1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 14:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63735613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF8656E3D0;
	Tue, 13 Apr 2021 14:50:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16336E3D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 14:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7vvaqusq+2VmGUjSWpK+AcPSPzUCebgmbcz0vPxGay/+uuUJDBCnotCs3qh7eO1OYtFYGCIk59qyGJTcgz7TkLkVKZHQk7ijjnLEGcbj9eoPttMhpX5EsV6jtAKjvX5QwyJx+aOvI8Zn53jxP08RLjuQomnY/EijhhjVLZechjAE7CPUrayD3YAM9NNG/uT0AHjQwfgmVo/bQ0Va+mZ6wvzvSEABVcF5Tr6OhLpa7VjNNibytM4GF2WI6IP8Ndrcb6JgRtfHyWy0RTKiDoJOs3N7U8nkWoyEf6H/2fhV68WM+TwMLjQBvBdXajIKxXxyV0lZPEGlD4rQpH/5Av5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUI35XB6OmyezIgyGenVPz7bgbitYc34ac66BUYrlBg=;
 b=jXlVry36BhtITMYz/jG7X8c0msUJKv9sJR2bNzGyH1SWlAfeKihJCdf/8EYABiJWsAKde/H8BBsAu03lp2dwJHioCVVAED0e5OH16zRLMOn25ioCL7tzyPy10GhfqPjjS3Kh/oyz73kkWAe0Xo2qx5tpOEwmy3RSIDpC17mRPgmDiSF9B+Q/hdxe+Faz6F+j49aTRKUXc/Qp4WvrH7r8JbIXaLZWuXB/Rqc5H/58LkKdZlrgWBPTwwxH+aZkj0CCEBsWuDQ+/78un5smcHA6cmwDrPp4f977TjnIi+Mbusru14ewyD/zhn9YOpICqbZRg873bWIo28wtspnyeC0gwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUI35XB6OmyezIgyGenVPz7bgbitYc34ac66BUYrlBg=;
 b=glz/cWZwVVnimqSjLqQpjPc+9HUJKYIBPfvxH9M546DItIbcU1DsOobMA67K3Z9cg0cedUk8fJeK2et9Hg2nUWTeB2BpTmCuaDA39dlfJ+FhxhlR0t7A8pxgtNr0QcPMyR3zjuT5I6qL4Oq2C/HB5Yt0deo0DMrjC+9KXMlFKAk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 14:50:02 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 14:50:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs interface
Thread-Topic: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs
 interface
Thread-Index: AQHXMGRnagUGaQxEFECAkn/rWX4RM6qyai2AgAAdeb8=
Date: Tue, 13 Apr 2021 14:50:02 +0000
Message-ID: <MN2PR12MB4488352A4E825B5A9A21681DF74F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210413125601.50387-1-luben.tuikov@amd.com>
 <20210413125601.50387-4-luben.tuikov@amd.com>,
 <DM6PR12MB4075F8764B78EBB20D5446FEFC4F9@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075F8764B78EBB20D5446FEFC4F9@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-13T14:50:01.862Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec712fd1-c561-4912-3dbe-08d8fe8b6b32
x-ms-traffictypediagnostic: MN2PR12MB4014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4014270AA1CC07895F79B656F74F9@MN2PR12MB4014.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23XYxnWriU0nuo8zFIWixk+ErKsVmb64JaCUZ9SQXhzcISk5zNZCCAfeaP7+ziogJRZ0KkJsbzchNgjN+HfPTLL7nNHpf5OijDzkn7wBVRtfnZr/EAcaTycOyk7oZpAW7Qf1AOgWfPg4ZN67KviJfh9i4a2qHK1dmcolglx1gZ2eIy3bvbZlZNpPNLRwN8rvf7S7i9pOTfC/ng9krfchmEUS1S83jBpQh2mChIoAY09PVerb0Cgn8tZfPdIK4/RdsXqJ5u1jBAgXXKMs6a9vwBfDn409O+b+ubsRGxM45UZb5Of3+LQ3LDecCqBWiLgWqehTGZepgJRohYNQ2qNJms0HTq1H3Z7KZ9HnobmC05Vo96XZEXehEZrcEjuMLV7N7slnGsT/z3ODYifssRUkbtRFvajp55n5sXJ49QvhSseKI61TXQ/z4hfUr2R2Mw52W8LDuYNV8YQpkus3RQpCdF425l8+9xDX3WAhoWhpYA5DINTmRA8u2UDvBMPElzVyhkXG1/rn6iKNKBWQ+mYyT42/hXugMB6kwZpZ9RNCdE1y3pkvkF79mPnyTfD9Mu7g8PtdYgl+xCOEo0vlZ0Gherk7D4S3T0BTXLVDq4dpJDg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(19627405001)(86362001)(186003)(2906002)(6506007)(110136005)(76116006)(316002)(83380400001)(478600001)(122000001)(9686003)(71200400001)(53546011)(55016002)(33656002)(38100700002)(66556008)(66946007)(64756008)(66446008)(66476007)(52536014)(5660300002)(8676002)(8936002)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bBjJsmE222ABk58roO8+xZtSOFh+JcOG8GeAcx+F3gYQFbgf9eOBduQQwgx8?=
 =?us-ascii?Q?nlE0o1iiecdTchTi3X7uR9H86EwB8yyWKGuYxMc3XpkQ9a0jchBwt/Sj0Yod?=
 =?us-ascii?Q?inggJGiGvOdj77b7Skpk7uce5ZvL3vgI/FLvySTgDJLApXxNYz8CMZlwT6eu?=
 =?us-ascii?Q?KjflFbsI1GSXsOoog/6SiVatAs0KWWSahFt6H1Y5h5sdAp1ksD0f5J2aRSkr?=
 =?us-ascii?Q?e629Cs3Ds2vENsfOvT9nwAyLyrMKmRoBt+G9YTnyQAFRgg0sn755X3yPcQ4F?=
 =?us-ascii?Q?+xPmaWEzyNgEvSd7xdThC9F8XX7BtOIoEtz9Ww4i9jgRI/cFxih4332FV2gz?=
 =?us-ascii?Q?NVUIRH8ZQbLMIFB1ON72mZUTPdpARCcWlsdr7Kf8bwCGD0bF4mawQsAt8Uah?=
 =?us-ascii?Q?bh1Qeyp3YyGMvcJU724n+0CeHWfLzrTwvFfsKytzbxvqGXIeWv8NS4Uygr9T?=
 =?us-ascii?Q?tPDybDCZ37fCxARF+A2im/fLqCiD1reJXBc2UhoBPC+DLTmu/dJkS07k59HU?=
 =?us-ascii?Q?tAplrIGn3KQIvOzlO7UI/7K63tPpAEK7XrnoHQO7ptANbOKLDwZ6AMZjwdGi?=
 =?us-ascii?Q?DxBsG/Q9dYa0U33jKa6P71murqUeLv3t5py1mVV74A5p2gyXXIvEgmI0AtA2?=
 =?us-ascii?Q?9/pszrD0+I0DQvSI3iBCToHligLtzKihz050WP6rEss4znK5J38lVBi3xesl?=
 =?us-ascii?Q?JuU9EhvIWcnfMVEjv4EczzYki2N/QNtiUMyLOJyX+v52Y8Yn4WKz+RqLRSVF?=
 =?us-ascii?Q?tmxpyjJNnE0meMlQJdWXzQ1yMI9vXrs89Bo8bm0K7Kg1PMm58SsTZkxe3FBJ?=
 =?us-ascii?Q?X+UyYH05iYY994OtUNZ8syqEJTaH2kMG3TUsm74kMJzPsVHoXsYjqlT159e2?=
 =?us-ascii?Q?JGsFMqUyQ6H3D+IlELZrHmtJp5oxRgcQq6pl6yO4O6/bDnhBg5ZA5USs0u2B?=
 =?us-ascii?Q?v8PqeQAeXMyKC8Dd/pcNgKNcpQl+TJqUHGwbKnXWqpeoskXM5+mEngXTnn1A?=
 =?us-ascii?Q?cXc1tDJRkqxBmJXsrEWmVcrsVUuOp0JlQMmZKxSg/DGg96BG7vUqAx8+N5Wt?=
 =?us-ascii?Q?OZceyZVa/5JFsEZYSH2QZmBK+RC1xbP+UcCNQmImImrwkBuvNgpR3MmPDoqM?=
 =?us-ascii?Q?/IhSe63/MgxPzLx/zh/AIBd9JIa38kxmTT61d+GnlCsXtou+hkvLWFrFJjat?=
 =?us-ascii?Q?lGOZo3J5XIZKQvZQTrYGyHgPG1xvuQzVLu8OqEYbtjGzi4eYvFw8aVigkTrg?=
 =?us-ascii?Q?4gpZ2I2qOcU8eICiRJPulQbPSv7ehNW0LezYtExhd5UWmE3UNoFS83kwNRZx?=
 =?us-ascii?Q?y/gTWWa9SKmFXS4rQ4Rv6nER?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec712fd1-c561-4912-3dbe-08d8fe8b6b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 14:50:02.3775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcXTKPD6HRRTAxBiCoang2nHc9r9CBzkg07mgcSPLzONOgDXeX9i5LNPvKnWBJnyagj/ie3W03xgbfg8g8ISjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
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
Content-Type: multipart/mixed; boundary="===============0693513294=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0693513294==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488352A4E825B5A9A21681DF74F9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488352A4E825B5A9A21681DF74F9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, April 13, 2021 9:04 AM
To: Tuikov, Luben <Luben.Tuikov@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs inter=
face

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Tuesday, April 13, 2021 20:56
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs interface

Imporve the kernel-doc for the RAS sysfs interface. Fix the grammar, fix th=
e context.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 47 +++++++++++++------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 30cda4b8a461..44dfb3613e37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -274,7 +274,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct fi=
le *f,
 /**
  * DOC: AMDGPU RAS debugfs control interface
  *
- * It accepts struct ras_debug_if who has two members.
+ * The control interface accepts struct ras_debug_if which has two members=
.
  *
  * First member: ras_debug_if::head or ras_debug_if::inject.
  *
@@ -299,32 +299,33 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct =
file *f,
  *
  * How to use the interface?
  *
- * Programs
+ * In a program
  *
- * Copy the struct ras_debug_if in your codes and initialize it.
- * Write the struct to the control node.
+ * Copy the struct ras_debug_if in your code and initialize it.
+ * Write the struct to the control interface.
  *
- * Shells
+ * From shell
  *
  * .. code-block:: bash
  *
- *     echo op block [error [sub_block address value]] > .../ras/ras_ctrl
+ *     echo "disable <block>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
+ *     echo "enable  <block> <error>" > /sys/kernel/debug/dri/<N>/ras/ras_=
ctrl
+ *     echo "inject  <block> <error> <sub-block> <address> <value> > /sys/=
kernel/debug/dri/<N>/ras/ras_ctrl
  *
- * Parameters:
+ * Where N, is the card which you want to affect.
  *
- * op: disable, enable, inject
- *     disable: only block is needed
- *     enable: block and error are needed
- *     inject: error, address, value are needed
- * block: umc, sdma, gfx, .........
+ * "disable" requires only the block.
+ * "enable" requires the block and error type.
+ * "inject" requires the block, error type, address, and value.
+ * The block is one of: umc, sdma, gfx, etc.
  *     see ras_block_string[] for details
- * error: ue, ce
- *     ue: multi_uncorrectable
- *     ce: single_correctable
- * sub_block:
- *     sub block index, pass 0 if there is no sub block
+ * The error type is one of: ue, ce, where,
+ *     ue is multi-uncorrectable
+ *     ce is single-correctable
+ * The sub-block is a the sub-block index, pass 0 if there is no sub-block=
.
+ * The address and value are hexadecimal numbers, leading 0x is optional.
  *
- * here are some examples for bash commands:
+ * For instance,
  *
  * .. code-block:: bash
  *
@@ -332,17 +333,17 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct =
file *f,
  *     echo inject umc ce 0 0 0 > /sys/kernel/debug/dri/0/ras/ras_ctrl
  *     echo disable umc > /sys/kernel/debug/dri/0/ras/ras_ctrl
  *
- * How to check the result?
+ * How to check the result of the operation?
  *
- * For disable/enable, please check ras features at
+ * To check disable/enable, see "ras" features at,
  * /sys/class/drm/card[0/1/2...]/device/ras/features
  *
- * For inject, please check corresponding err count at
- * /sys/class/drm/card[0/1/2...]/device/ras/[gfx/sdma/...]_err_count
+ * To check inject, see the corresponding error count at,
+ *
+ /sys/class/drm/card[0/1/2...]/device/ras/[gfx|sdma|umc|...]_err_count
  *
  * .. note::
  *     Operations are only allowed on blocks which are supported.
- *     Please check ras mask at /sys/module/amdgpu/parameters/ras_mask
+ *     Check the "ras" mask at /sys/module/amdgpu/parameters/ras_mask
  *     to see which blocks support RAS on a particular asic.
  *
  */
--
2.31.0.97.g1424303384

--_000_MN2PR12MB4488352A4E825B5A9A21681DF74F9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 13, 2021 9:04 AM<br>
<b>To:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysf=
s interface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Series is<br>
<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt; <br>
Sent: Tuesday, April 13, 2021 20:56<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &lt;Alex=
ander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
Subject: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs interface=
<br>
<br>
Imporve the kernel-doc for the RAS sysfs interface. Fix the grammar, fix th=
e context.<br>
<br>
Cc: Alexander Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 47 +++++++++++++-----------=
-<br>
&nbsp;1 file changed, 24 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 30cda4b8a461..44dfb3613e37 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -274,7 +274,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct fi=
le *f,<br>
&nbsp;/**<br>
&nbsp; * DOC: AMDGPU RAS debugfs control interface<br>
&nbsp; *<br>
- * It accepts struct ras_debug_if who has two members.<br>
+ * The control interface accepts struct ras_debug_if which has two members=
.<br>
&nbsp; *<br>
&nbsp; * First member: ras_debug_if::head or ras_debug_if::inject.<br>
&nbsp; *<br>
@@ -299,32 +299,33 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct =
file *f,<br>
&nbsp; *<br>
&nbsp; * How to use the interface?<br>
&nbsp; *<br>
- * Programs<br>
+ * In a program<br>
&nbsp; *<br>
- * Copy the struct ras_debug_if in your codes and initialize it.<br>
- * Write the struct to the control node.<br>
+ * Copy the struct ras_debug_if in your code and initialize it.<br>
+ * Write the struct to the control interface.<br>
&nbsp; *<br>
- * Shells<br>
+ * From shell<br>
&nbsp; *<br>
&nbsp; * .. code-block:: bash<br>
&nbsp; *<br>
- *&nbsp;&nbsp;&nbsp;&nbsp; echo op block [error [sub_block address value]]=
 &gt; .../ras/ras_ctrl<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;disable &lt;block&gt;&quot; &gt; /sy=
s/kernel/debug/dri/&lt;N&gt;/ras/ras_ctrl<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;enable&nbsp; &lt;block&gt; &lt;error=
&gt;&quot; &gt; /sys/kernel/debug/dri/&lt;N&gt;/ras/ras_ctrl<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;inject&nbsp; &lt;block&gt; &lt;error=
&gt; &lt;sub-block&gt; &lt;address&gt; &lt;value&gt; &gt; /sys/kernel/debug=
/dri/&lt;N&gt;/ras/ras_ctrl<br>
&nbsp; *<br>
- * Parameters:<br>
+ * Where N, is the card which you want to affect.<br>
&nbsp; *<br>
- * op: disable, enable, inject<br>
- *&nbsp;&nbsp;&nbsp;&nbsp; disable: only block is needed<br>
- *&nbsp;&nbsp;&nbsp;&nbsp; enable: block and error are needed<br>
- *&nbsp;&nbsp;&nbsp;&nbsp; inject: error, address, value are needed<br>
- * block: umc, sdma, gfx, .........<br>
+ * &quot;disable&quot; requires only the block.<br>
+ * &quot;enable&quot; requires the block and error type.<br>
+ * &quot;inject&quot; requires the block, error type, address, and value.<=
br>
+ * The block is one of: umc, sdma, gfx, etc.<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; see ras_block_string[] for details<br>
- * error: ue, ce<br>
- *&nbsp;&nbsp;&nbsp;&nbsp; ue: multi_uncorrectable<br>
- *&nbsp;&nbsp;&nbsp;&nbsp; ce: single_correctable<br>
- * sub_block:<br>
- *&nbsp;&nbsp;&nbsp;&nbsp; sub block index, pass 0 if there is no sub bloc=
k<br>
+ * The error type is one of: ue, ce, where,<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; ue is multi-uncorrectable<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; ce is single-correctable<br>
+ * The sub-block is a the sub-block index, pass 0 if there is no sub-block=
.<br>
+ * The address and value are hexadecimal numbers, leading 0x is optional.<=
br>
&nbsp; *<br>
- * here are some examples for bash commands:<br>
+ * For instance,<br>
&nbsp; *<br>
&nbsp; * .. code-block:: bash<br>
&nbsp; *<br>
@@ -332,17 +333,17 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct =
file *f,<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; echo inject umc ce 0 0 0 &gt; /sys/kernel/=
debug/dri/0/ras/ras_ctrl<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; echo disable umc &gt; /sys/kernel/debug/dr=
i/0/ras/ras_ctrl<br>
&nbsp; *<br>
- * How to check the result?<br>
+ * How to check the result of the operation?<br>
&nbsp; *<br>
- * For disable/enable, please check ras features at<br>
+ * To check disable/enable, see &quot;ras&quot; features at,<br>
&nbsp; * /sys/class/drm/card[0/1/2...]/device/ras/features<br>
&nbsp; *<br>
- * For inject, please check corresponding err count at<br>
- * /sys/class/drm/card[0/1/2...]/device/ras/[gfx/sdma/...]_err_count<br>
+ * To check inject, see the corresponding error count at,<br>
+ * <br>
+ /sys/class/drm/card[0/1/2...]/device/ras/[gfx|sdma|umc|...]_err_count<br>
&nbsp; *<br>
&nbsp; * .. note::<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; Operations are only allowed on blocks whic=
h are supported.<br>
- *&nbsp;&nbsp;&nbsp;&nbsp; Please check ras mask at /sys/module/amdgpu/par=
ameters/ras_mask<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Check the &quot;ras&quot; mask at /sys/module/a=
mdgpu/parameters/ras_mask<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; to see which blocks support RAS on a parti=
cular asic.<br>
&nbsp; *<br>
&nbsp; */<br>
--<br>
2.31.0.97.g1424303384<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488352A4E825B5A9A21681DF74F9MN2PR12MB4488namp_--

--===============0693513294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0693513294==--
