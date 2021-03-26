Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22719C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 05:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9C861A45
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 05:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9C861A45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4069C6E17B;
	Fri, 26 Mar 2021 05:12:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DCB6E17B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 05:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmJ0WNHH535eD4vWw/9j4a2Za1eVHSCysqbr1WVTZsFEVTlpUJk/PW+LBJn8ibxW1lM61C+zNixKe5nUSEvIP9UkxA40RzFbDkARilJvYvsLX3rGhRC1JIHdGQl8VkWSPbeRUGUQScm3HPBH+9vafM6K9VW2FgG9f+2TJpOFHcUDrqhzcgpMW9pYRmyOJoA1l90buXLZsc5spWy9xDUo1nLGnuTQtoXJrWafQ0FAx9+4QcP/L8vv9Y10VBsjiyLXPXSOE+DUrUpWTU6bpwepK6wMal7JG6M+Bh0nngA8vx9a00mx+GTuJMZ/laoLAgpxw+2/9yvhHQaDeA5pBl22VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDZOR2MedNHWiuAWdbHIJMIxtmuMUURm2yXaRnc1Glk=;
 b=NZnAOsU47KdlApgq/PxAP9Mpy0J1INzIrKUV8TRSVLr5Vcy2nkFViUpexy9GIrHziVxk5SXukcuQn6Rw0Qng781+H+ZVayeGUDAOHPEOMu4aZZVHIHnsQqPK1H5WicqvQ6CHTS5t3MZbT8MBhNEgVvFpCGUceHvGj1lMa6lj/pH0RAMYaRilU20M1Jz/XQ49Bt1D6otlKf5tUhXK/yl4/tQYRB6/x9KbF/Qc+72KXNTa//UTQN1r/kWU8IpjoGd+gDfpzURZQaGObbNYmYdefaZ0yNv4ErZXWP/amht3wcU1E+VMbctSk6d/0uJrEcJw3tQA/dSLSjEDAfzinGBMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDZOR2MedNHWiuAWdbHIJMIxtmuMUURm2yXaRnc1Glk=;
 b=m6ZTjpdb+eh+Mv64NleetcoSmNJs5mQH9louGktEejOyXY9GP5xT4+c7Ip8Aa1sJhMzsh2cc9toG3Bt35EeNQDjhTAROcFRS6bSYMzP+vUhG4g2Yr93wyPqdBXtWQeu/UF1NiAvUeBiexNumHchmKGLKIrBVHO6VEwgSpA2JebY=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 05:12:14 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3977.024; Fri, 26 Mar 2021
 05:12:14 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Thread-Topic: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume
Thread-Index: AQHXIfnLwTkSKynoo06EoppnIeiQ36qVuR6A
Date: Fri, 26 Mar 2021 05:12:13 +0000
Message-ID: <MN2PR12MB30222D6D0B035BD54CD66464A2619@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210326043731.779691-1-alexander.deucher@amd.com>
In-Reply-To: <20210326043731.779691-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-26T05:12:13.226Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15ef4422-2b34-483a-4e61-08d8f015b7bd
x-ms-traffictypediagnostic: MN2PR12MB3535:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3535700F3AA38FEDC85C8EE9A2619@MN2PR12MB3535.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhsbsoFBnzUdkGYKTwgzGlDR+3Eb5J8WD7ELC0Fn0pO9/Oxq2is2tAxUw2M/zqTDsG221uGDgM3mb+ZCzh8HEK9jcGuw0FrKg62PCQDG2YJXqSJ1WvKftOIsniMUWTOQGHv/X/IVV/uFxlEE6rGDq4kXruWn1d68Kuaxsyxao3/zVtxs6Afi4vGs0cnGafr9JuHHKQEabuLu2Jd+hSEdYJM8OMkDUw4Hw/wzMZOFeZ2EdH2RkmDkbgMHtr8oRC6+uAHw03njo78BLE8lW9tqTTEAdR34TMDyt2rG5nWhpYMO0L0jao7LcNE12/MtTI7HYNXYv2QaYOYkjBDetkKV0dNAr5mmF0RYjZTHs0Ln5VsW5fPt7WvPXYNoch7O1UTWdKyNVlbpVA/zjCAbgDobs2D0kqiPiAVYHep0k+ymCOOPnYJZ+YkPuxOPDnTjBlqJVft8433wkL0mjo3ugRgBYzue0wbkhqo21KQgrlrvZFc8HLuHd3GDnvu7gBxtViI94HAqJDGas5ZdSl2VsNUMNthocSolzZugjUe3h0yUpDkFXieQwlBvG3H4yKUxbdGxn+7iL+9Q9+2exn+DHuOgKyLTw7TY9UUeQtOlyAkJRYY7xtxICu9+XJwzM9QfBQwnUdRUJpqtvBrsCq8RZURTrJmILwn+tZYI8PAXPUYgX4ryBcWiXoSaYucntwDMd4AAsvnGDmrPcXbLP8bQTJu7MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(966005)(2906002)(86362001)(9686003)(45080400002)(478600001)(66446008)(66556008)(55016002)(5660300002)(19627405001)(64756008)(71200400001)(66476007)(52536014)(6506007)(53546011)(7696005)(66946007)(8676002)(8936002)(316002)(83380400001)(186003)(26005)(91956017)(110136005)(76116006)(166002)(33656002)(38100700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9VFiaBzn7AKaa6estBOdpN+UtIOaqUtPG9uBxW9Iun5zKsOVSagrOSvC89?=
 =?iso-8859-1?Q?FCQuVb8rcWQh9UwhKg9zUiycRFSD2yh0O7hBrEr+LWFKP65IV8DlFgRKh5?=
 =?iso-8859-1?Q?Dp77flgqRnVdyzq3vNGMQE1v52hLn8jxMchHXzyROU99wqxRfGtn2JsPke?=
 =?iso-8859-1?Q?Iw7ASzjS3RmZOkK82K8i3tAknpyu43KbtNq2g3Wao+9JIHzj5NnfUtRbB3?=
 =?iso-8859-1?Q?iRQAMXA5iA05rS9ZAy7BXqLSJPEL3NL6tYJLcLYQvBgMJIXLhY6qX7nDWx?=
 =?iso-8859-1?Q?/IxcCB9rKT2IAuwvyAIB/48ieZ0i71BM6TLgWHay05WclKGcNqsmK8rOja?=
 =?iso-8859-1?Q?CAQM00iF2VmM7raEmjLRtiNRz1BcpqW19Wfx4TBpQvTzMzkaFS9ZsBYiA5?=
 =?iso-8859-1?Q?YuHZm8MM6YoESxUKjcIY1gOy47FOMN43PBPvFk8vqZAd6ClpVVgQmDVwL/?=
 =?iso-8859-1?Q?ktkzKAUQkNK5htNOREVhpdmKIbNPBdjQ7yzv7jkxL5jqECefTNZmMzNjzf?=
 =?iso-8859-1?Q?nmI1L6mm0QtRIXZS9K1aUS2sTq788CIvIliwKWkMofjrLl0/MmcdL9c6m+?=
 =?iso-8859-1?Q?oWb94jy0xXr3BgdOVEETAu34X55vyu9x6hn6Uy7K6WUDBBAafF1yNBgck4?=
 =?iso-8859-1?Q?fBXpgoWvbRn7rZ93pMV6ss6utqhX8CyF8yLryWf+bORdObfFtHgDIh8npW?=
 =?iso-8859-1?Q?9YKhfWgDgSoPzP5/IR/X/dgbufCtg9Q9PMAyWw9I33PW9a+OL6OE7pyUKn?=
 =?iso-8859-1?Q?Up5VwUQaSPe0GICfH7YI9CGT46kVHn7u6UnphqtJbG3eDahVbVw1TFVxzL?=
 =?iso-8859-1?Q?DFY9qQFFBb6ym11XTjMFZYIIeoj+0SIQJfAqjzaGU8MmjDzBO5HfHCfDzB?=
 =?iso-8859-1?Q?ND/ZHjd3+ImwMF6FREAY5E2JyYY/mze7bGxRWL+0qBFURWGrjbLoSKuEMk?=
 =?iso-8859-1?Q?szQrSrFRPNlxPVeOClO6zTgNA1gGbaqykR9Tga1uK+7kM4FEUdT++aHn9Z?=
 =?iso-8859-1?Q?2NNsNTmqA5+EuKnI2JVwljRs9MSXssDO+Q7CSGGh1aqqwdhzXgEu9/OmAW?=
 =?iso-8859-1?Q?YOqe/cWyssfe9Ezo7JuPed9RhQTEOZtpupi/jGlYz9lESDGvvCrcQMVtZ+?=
 =?iso-8859-1?Q?Y0s6RTsPsBVk/65CqtzjtBBDUGTcJ8JAjOhoy4GLsEilzhLl6yPot2iYmp?=
 =?iso-8859-1?Q?eQA63pegM3/HmJzN5WMYBUjT9j1yDFVRpU90yW3RwGYP9YqTn6UjRAkSBg?=
 =?iso-8859-1?Q?neL2u0BxI3YlvbnyE5u+bVl88E48Z35p9nVdZoQEmLuHyhICvZXDj1jR0N?=
 =?iso-8859-1?Q?EV9e1sklqeZT4b02GA4eSaemqdH3sjMz6yKhyOg5jLZ+WbEVKi5oSX/HjC?=
 =?iso-8859-1?Q?x8TomPO+uI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ef4422-2b34-483a-4e61-08d8f015b7bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 05:12:13.8882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/Xy1VzQ5ca8PNAtCQuweVAoBzT2WAzz4xvJTrQrbZ+NwtWxkxQxbvXj588wR0XX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
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
Content-Type: multipart/mixed; boundary="===============2125952834=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2125952834==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30222D6D0B035BD54CD66464A2619MN2PR12MB3022namp_"

--_000_MN2PR12MB30222D6D0B035BD54CD66464A2619MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Friday, March 26, 2021 12:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on resume

The SMU comes back up with DPM enabled by the sbios, but the
driver still has to set up the SMU/driver mailbox, etc.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index d4b804c7b986..462917d4d5e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1102,7 +1102,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
         uint32_t pcie_gen =3D 0, pcie_width =3D 0;
         int ret =3D 0;

-       if (adev->in_suspend && smu_is_dpm_running(smu)) {
+       if (!smu->is_apu && adev->in_suspend && smu_is_dpm_running(smu)) {
                 dev_info(adev->dev, "dpm has been enabled\n");
                 /* this is needed specifically */
                 if ((adev->asic_type >=3D CHIP_SIENNA_CICHLID) &&
--
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C97142ed601fb40e5733308d8f010ecb4%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637523302779786035%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D8T=
oBQ2CXNmbeA%2BH01D6frUUCvrsL4TzGiiId%2B2gVHi8%3D&amp;reserved=3D0

--_000_MN2PR12MB30222D6D0B035BD54CD66464A2619MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Friday, March 26, 2021 12:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/swsmu: don't bail early on hw_setup on r=
esume</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">The SMU comes back up with DPM enabled by the sbio=
s, but the<br>
driver still has to set up the SMU/driver mailbox, etc.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index d4b804c7b986..462917d4d5e2 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1102,7 +1102,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pcie_gen =3D 0, p=
cie_width =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp;&amp; sm=
u_is_dpm_running(smu)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;is_apu &amp;&amp; adev-&=
gt;in_suspend &amp;&amp; smu_is_dpm_running(smu)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;dpm has been enabled\n&q=
uot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* this is needed specifically */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type &gt;=3D CHIP_SIENNA_CICHLID) =
&amp;&amp;<br>
-- <br>
2.30.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C97142ed601fb40e5733308d8f010ecb4%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637523302779786035%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3D8ToBQ2CXNmbeA%2BH01D6frUUCvrsL4TzGiiId%2B2gVHi8%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7CKevin1.Wang%40amd.com%7C97142ed601fb40e5733308d8f010ecb4%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637523302779786035%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D8ToBQ2CXNmbeA%2BH01D6frUUCvrsL4TzGiiId%2B2gVHi8%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30222D6D0B035BD54CD66464A2619MN2PR12MB3022namp_--

--===============2125952834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2125952834==--
