Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85388C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E9B64E04
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E9B64E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A57CD89CF2;
	Mon,  1 Mar 2021 05:27:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9AD89CE1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 05:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHKz+IQYA/f+XMDQpTfEf9oRExBfEzv5BYbqUsoYdETX1TuziRiqTJFcqw8EUnP2sb0ocSTVYv4S7SGGIoarl5xoRUL4O4qlNQ/NZ2OSukEmqVELTxyHt2sC882sCt0b3lu5VXY5FHVn+Sxcnjiu1aZ3DC509PmK7eIjAC1L3IgxgFSyqI1zbVXeBDacQ+NnMIdCfHT9f+tonaX3CXb2Rl8WJVmqTtemaki7JafkgyTxeMJTo8cTB6Ucfx+g7MsXW13Kpc+lc/X4Cpv2eBp52uRJ/64XTzVkni/FuFmyp+ErWkitI+uiGPNVc4uq4nACfrPKIFJq9c7g1cb9PXKptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D9GwZHnw9R0jXUy0+TyUcgITfKht9UthqcwT+ACobc=;
 b=NS6Hfr7vGXGzjGl/C0QDvHMsr8/Sy8RCxLLmUht3BB9nuSRfjXco6z9BpAhLy4OCYbtxFosSblRQKZlcRkB4uLnF86xbmVpQe/HjsygbDHAieRmsQx2lzQNIbxSy6HS00tamcglUUp5nGPFCpiZRCPanhBl1J2Gi0C+NQMU7zlD0qMWs9dEr/em3HtCuoe0TaFn68VDzi7OJHZ0nH3GUORHQEtEeVBa4dWqaBrz8NC0kne7jIRH1kYx3Im+0RHTazoJDSCFJkDeW6yhM4MbRF8CfJIxzsUPMkVicev2T2fJs5bXebxUR6/CtEkLMB+SdvOBkXQxPHNXiq50xI3EmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D9GwZHnw9R0jXUy0+TyUcgITfKht9UthqcwT+ACobc=;
 b=VxEush7hx7yeWjq9I/waYJy0C24dMKf5srqLds+AYHxTz4FUxgwXnmpf/mQm3OnZAulWyLSr0EfQswkCjkdoZYrFUno927IqSdaCMxSejvLM/KCRDDj+Me+0hWz/kz7zwh/Y3TngOnFpONXsfho2aRG094Oc1C4UUMF3fGTRNNg=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3439.namprd12.prod.outlook.com (2603:10b6:208:cf::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Mon, 1 Mar
 2021 05:27:16 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 05:27:16 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: correct TA RAP firmware information print
 error
Thread-Topic: [PATCH] drm/amdgpu: correct TA RAP firmware information print
 error
Thread-Index: AQHXDkXdB5Q8QwslA0eiOugzC9Yv0qpumZYAgAAAY1Q=
Date: Mon, 1 Mar 2021 05:27:16 +0000
Message-ID: <MN2PR12MB30224F72ABDEE13E89818213A29A9@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210301025130.17402-1-kevin1.wang@amd.com>,
 <DM6PR12MB40750ED41BBCC62F237BAB66FC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40750ED41BBCC62F237BAB66FC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-01T05:27:15.365Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 284dcbc9-f32a-4cfc-e004-08d8dc72ad1b
x-ms-traffictypediagnostic: MN2PR12MB3439:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB34391F3B964D1D1272E5CDE0A29A9@MN2PR12MB3439.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcvJCwn/IClwE9acWwzXcxDujPbPkLqFnsnE+o7mPVJH++N6goLdruqF101y1+qhO8TAtYD4KSWqow1D3Ed4gnntD5o0Azv6H0zshhMmWkqB08d4N7ii+g8RrcN6X4JuHqiWcbLi90WGEIOf0Qoq7Mw02I7AkinvvHpfARUzIXVbfbVUMbRqzLNdjiWJXrXEJ/S/W7o8JDJyo/USn1s3iU/abyr/rWLSRHTsTQa5pTIWq/qjSbwRm3lp3SN2nH5bgFv+aZrhp9ridqT8cSFkO/mNE+OwXKWH/8N+YknCY3INynqHBkVrHXBqmePHR79Omb6ZwxOLyMV4EhBX0Yg0euliWbwP54YTQ/G/V+jcltmLHlxIWz8t9QzA3YB2cD0z7fAQ4a2UWBuSCZOP6hckUL3e3vIYJcbZBXPrnRiskws7M2AoZUqPOtxMQRniwgngCtqfAgXH8Tz/DTN1bAQtf+0zcnsKn2yKsagprzC31An3TU4fOhmaMlwmxCK7QP03+0YmEZKowCDYLbm7Ah7Jc5weL6obE0iNmFtq05+3Sji+xiLh5Ol8h986vGUwN5p7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(71200400001)(55016002)(9686003)(7696005)(86362001)(186003)(33656002)(26005)(53546011)(8676002)(19627405001)(83380400001)(8936002)(6506007)(5660300002)(66556008)(66476007)(64756008)(66446008)(110136005)(966005)(4326008)(76116006)(478600001)(316002)(166002)(66946007)(91956017)(45080400002)(2906002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?NGPIj4g1+i3Gwf8Iv/8/Zsw9RxFW9sjVLmur0lr8DY3WjhWzHCkUPY4BMt?=
 =?iso-8859-1?Q?3RtSW7rKkBSIxnc5SKzRhqDCqfRwOxM3v1DEhE19MxeOmBaFSFYMUem3LX?=
 =?iso-8859-1?Q?O/pwH1d+TPQnNGa8W+Sy9QovuEmD7EAc4EUEfbsl/rBbwVCKai81GgUbbF?=
 =?iso-8859-1?Q?A2teFxd1F5+XdbT38XerFnEQyS2xCwb3c7eUh9Mu1ie8bAEEethX8oA8AN?=
 =?iso-8859-1?Q?RJ0pOf5MQmfarIdTx8MDHGpcsfiWkJKFddmAWkTTzbn0tf5o/xs72YLfzi?=
 =?iso-8859-1?Q?yfSFPLq+X+2e3RJsJUcqnnO/nVuVBgyVWSQgn35L8du3wnyX4RvaBLkJxi?=
 =?iso-8859-1?Q?6te+D//IpcsRkSMpc1X7ksuw7Lj9qCLn6it1ET43pDwGF4XscBTPn8sYjC?=
 =?iso-8859-1?Q?a2H897MXNbvMH0yYH1JmLypZweHTBXbmfpmTeEXJ1vKeSPEjGnOW0R7EfV?=
 =?iso-8859-1?Q?eklwbUaFNPvFPGl1yGz7uytC9FPxtizDB0tVnbjxZyo9qzO+y6l9vgp1WA?=
 =?iso-8859-1?Q?hr8eOyoYUeVZOZqkkrKSHhEMPiol6w8eimVqvvK7gLscSbUk0GdJbMNsz4?=
 =?iso-8859-1?Q?zpVj/KsqDb36DWvvbams80/Uh20NVVdXoKeoLNi4+oP69UQkkawLlnVDrK?=
 =?iso-8859-1?Q?wsDK5W0Sa19kV+v+horUevH7J6HbWuRThvxLShgybP4QVTlOJtbx/RkaWQ?=
 =?iso-8859-1?Q?E32/ZPful2AJAxUQkZCNjN9T5a8zi1RdsYlcSxs8qzSDFFTRGICr241/le?=
 =?iso-8859-1?Q?d2wLl2FgGL6xOpifD3aTQrWIJTOmwcxWToXnGkB/4JZFI+EH8jLM70rkO4?=
 =?iso-8859-1?Q?Xflycycvm1MuA+wi8O1ooWjh7XAeKl78qNbg240rO/2pD7GSE3Gyr+2Zfa?=
 =?iso-8859-1?Q?qM7lk9l0bpeXtR8cSL95ghFkmbK6tGjYcuD9ZN/wyWmLrH+ZX0guskmDwD?=
 =?iso-8859-1?Q?ibJjYSShaL8nXvOojY7YKVTUvcGKQj0alS6/+KJTncgzXm4I8JY25+eS71?=
 =?iso-8859-1?Q?iTBmMRNpB9pY5W6wdgMTC3aJyHQgojqSET54CGWjz5ZYgEbr6oIeRSj3rr?=
 =?iso-8859-1?Q?0ZrGdlsWdjepJco4gGNOS9/MFCRFjoNdCUXqAu5vcR7enS2GREHnGOPbrC?=
 =?iso-8859-1?Q?ik8oCM9meBUvATSe4xf3iVFfGz57Fz48yELoCaZAbH1l/lBooS6Ki2YhK3?=
 =?iso-8859-1?Q?GRhQMZERs1WorM5TBzkRs2f4WIhSC4CiauAeELKwOp5SVBNcb0RQMCq+dn?=
 =?iso-8859-1?Q?WOCL2MlOtOamhbtIx0wNENhYeJrw32kZ1wov9JM6JGi33VWHqiBYefzndl?=
 =?iso-8859-1?Q?qHoyLQcRHGioT4s4AxZyeImX4Bs/lHmdDt7aDpInIhWhkkva4aj0w3SZq/?=
 =?iso-8859-1?Q?XQ36Q1Hkei?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284dcbc9-f32a-4cfc-e004-08d8dc72ad1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 05:27:16.0793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nV4BM+YQyfvYrwljOQofmQd9ORzcmds4KdfzOrAU7yVRwZoK4YYzTycBuszMpmqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3439
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============1242284769=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1242284769==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30224F72ABDEE13E89818213A29A9MN2PR12MB3022namp_"

--_000_MN2PR12MB30224F72ABDEE13E89818213A29A9MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

yes, I have the same idea and agree with you.

but patch is merged, I will add a new patch to refine it.

Best Regards,
Kevin
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, March 1, 2021 1:23 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.co=
m>
Subject: RE: [PATCH] drm/amdgpu: correct TA RAP firmware information print =
error

[AMD Public Use]

Instead of hard code the number of TA, it would be better to leverage enum =
ta_fw_type definition, explicitly call out TA_TYPE for each case in both am=
dgpu_firmware_info and amdgpu_debugfs_firmware_info_show.

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wa=
ng
Sent: Monday, March 1, 2021 10:52
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.co=
m>
Subject: [PATCH] drm/amdgpu: correct TA RAP firmware information print erro=
r

miss RAP TA in loop ( when i =3D=3D 4)

Fix:
drm/amdgpu: add RAP TA version print in amdgpu_firmware_info

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reported-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index a5ed9530f542..6c8ea9d26320 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1472,7 +1472,7 @@ static int amdgpu_debugfs_firmware_info_show(struct s=
eq_file *m, void *unused)
                    fw_info.feature, fw_info.ver);

         query_fw.fw_type =3D AMDGPU_INFO_FW_TA;
-       for (i =3D 0; i < 4; i++) {
+       for (i =3D 0; i < 5; i++) {
                 query_fw.index =3D i;
                 ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev);
                 if (ret)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Chawking.=
zhang%40amd.com%7C76e6934844e14fd942ec08d8dc5d042d%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637501639364874702%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
ouIjHlz93nX%2Fj3gZ9tdhHxYX501bJmQm3UzqpDwSJGw%3D&amp;reserved=3D0

--_000_MN2PR12MB30224F72ABDEE13E89818213A29A9MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
yes, I have the same idea and agree&nbsp;with you.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
but patch is merged, I will add a new patch to refine it.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, March 1, 2021 1:23 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;; Wang, Kevin(Yang) &lt;Ke=
vin1.Wang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: correct TA RAP firmware information=
 print error</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Instead of hard code the number of TA, it would be better to leverage enum =
ta_fw_type definition, explicitly call out TA_TYPE for each case in both am=
dgpu_firmware_info and amdgpu_debugfs_firmware_info_show.
<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ke=
vin Wang<br>
Sent: Monday, March 1, 2021 10:52<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Li, Candice &lt;Candice.Li@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wa=
ng@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: correct TA RAP firmware information print erro=
r<br>
<br>
miss RAP TA in loop ( when i =3D=3D 4)<br>
<br>
Fix:<br>
drm/amdgpu: add RAP TA version print in amdgpu_firmware_info<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
Reported-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index a5ed9530f542..6c8ea9d26320 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -1472,7 +1472,7 @@ static int amdgpu_debugfs_firmware_info_show(struct s=
eq_file *m, void *unused)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_info.feature, fw_info.ver);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query_fw.fw_type =3D AMDGP=
U_INFO_FW_TA;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 4; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 5; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; query_fw.index =3D i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_firmware_info(&amp;fw_info, &amp;query=
_fw, adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Chawking.zhang%40amd.com%7C76e6934844e14fd942ec08d8dc5d042d%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637501639364874702%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DouIjHlz93nX%2Fj3gZ9tdhHxYX501bJmQm3UzqpDwSJGw%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Chawking.zhang%40amd.com%7C76e6934844e14fd942ec08d8dc5d042d%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637501639364874702%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C1000&amp;amp;sdata=3DouIjHlz93nX%2Fj3gZ9tdhHxYX501bJmQm3UzqpDwSJGw%3D&a=
mp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30224F72ABDEE13E89818213A29A9MN2PR12MB3022namp_--

--===============1242284769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1242284769==--
