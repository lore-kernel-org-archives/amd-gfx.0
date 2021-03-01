Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DBAC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0456664E31
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 05:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0456664E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B77D6E436;
	Mon,  1 Mar 2021 05:31:34 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724046E436
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 05:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSjqUadTflFaOrP1G3OMnyKSLFBW5iVfUPLmNgogGYq2xq8J8AMo+F4WHO2n28HhrzjwaSqspQhEZCOsvuplMNLO+ZN4UogR80oG7f8WUNfMMm27KDPB76AgqoF5mJqsZwvrDakWsJeZijag2BfiL7Khb3AEpg+doNeFm1ie7nJauhCsmzDxRfasNt15zn+DC9t/WJZIT/sw/EzsVwKf8uN8fSyO29J0LmUZjvtlozHKbLoSf/jcj6TOXZ+cl0CUpcRjTD7y5EtvgOeo8/FgO0cek3iotV6HCL6IVzWuVg0K7i4ujFRhzLENqGUIwi2Bz86S2dEJdgLo0lvugetNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE0RFMj+1QgYKi0APP5AyV0pa1YcL1icNNJkXxMzFHE=;
 b=BpLoJxlaODfQO/r6GlITvX3cqzdywfOecQLrnksN3TzkUMVws2C/NZK5+kEwn/Pg6E8/H8kIPNWpnubCUfx1f96ZuChsQnbossVVhqrYi9SLvlOIl8R2L5TdvHm8v7nldGUCc5qZY4OeYSEWXnca+khoaJaA/lMUb8nXBICWj/YBofEI4OPXmojUzYcaLRbksUBkztvcy2EGJFElTFRkpDJ7iO8AJ6gSPf5R6Ca1qNTQQc3Ryp+YKnDAPKzYKu4XKn6/BZI/iih34E+kAfMZj+/G38oRNw/ynHzQZbGMGyUvgC0AtIzB1FIqAnQI/FtbQ337vMfJRsHnXPbRiw+1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE0RFMj+1QgYKi0APP5AyV0pa1YcL1icNNJkXxMzFHE=;
 b=IiblLVVM3dRG181mAzQDqVRD2B9W0cwzbF6jea8KvDQP/LvtJhMfwM6FkSLuQpzBDRYqo0DPXWXDoJAi8iSzj8xsbo084oNcWJW1FYdxmMG4UfFhBhLYOQlZqdjbI4Ly970a7fuTt9ysq+RBh7+WkJARy7/PG6v9Wlsv7vklRz0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Mon, 1 Mar 2021 05:31:30 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 05:31:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct TA RAP firmware information print
 error
Thread-Topic: [PATCH] drm/amdgpu: correct TA RAP firmware information print
 error
Thread-Index: AQHXDkXj0wgc182Hs0yzw+RPVpQQM6pumLUwgAAB1ACAAAEHYA==
Date: Mon, 1 Mar 2021 05:31:30 +0000
Message-ID: <DM6PR12MB4075D7EB6E313D23FAE2732AFC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210301025130.17402-1-kevin1.wang@amd.com>,
 <DM6PR12MB40750ED41BBCC62F237BAB66FC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
 <MN2PR12MB30224F72ABDEE13E89818213A29A9@MN2PR12MB3022.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB30224F72ABDEE13E89818213A29A9@MN2PR12MB3022.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-01T05:31:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c424f3e-044a-49f1-0040-08d8dc73449b
x-ms-traffictypediagnostic: DM5PR12MB1708:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17085449D10C97CA703A3B14FC9A9@DM5PR12MB1708.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bS89NpzAwCiu0XUF0dChbHOBQ4PVQrdWylsFUl/GLkP2JambtXjrK+0Zt8mVo2LmxV90JW0Nds9OA8g91S13XDq+KwcJ+NzRXuZ1lBQYb7QlWRDRBIyH7tvMWwFXIS+SPWDn0ZK+p0bokZoOsSn38VhXGIUT74yAp0vIXi3Hv3WrMjpzoXI7f+IFOy7e13e7O93jpq3SM+CdS/dIGYq0UBx04NOk+SWn67I1GR01Ajkb1MOl7ksAnd7YJRwz1/FimRutJLxafCNxKxsle8wHlDyQrE3bv4PSlMg1jUS87ZjIiZHWDC1DnGNpYcKb+6eea1O0qH9gsUvzik4agNwX4pHrtGpqGpElUkQ+/FK9aR4hHcg6fRH1hZ1kFGzO2qprf5YHhyHEQvJvKk023gPaSSNI4+Kk1CGDrneG6mE1s8R03/nUK9T4cgBLZCNcRqRSdpcdkQWs+BFtZnOEvhgNktrlfTgoF+eJ1H2TTItuGJQLLwN5BtgS5SROoAeokWSE0aQlyIaR0Up1ZjnwT0WLN1kL7ooTB575ADQXh43zwJtNIwDFVsiDiT0yMdQ71EDD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(7696005)(110136005)(66476007)(66946007)(2906002)(64756008)(66556008)(76116006)(966005)(53546011)(66446008)(8676002)(6506007)(8936002)(45080400002)(71200400001)(26005)(316002)(478600001)(55016002)(186003)(4326008)(9686003)(33656002)(166002)(5660300002)(86362001)(52536014)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/VFoueLbShyWdinu5mMGShcwykbUkpTK1ZrkLPdWUNjejXmYXyROdUxs5EbN?=
 =?us-ascii?Q?paROrpFYNwsNBBHWgGBr/FEPEs+Oxp3tG9GJ+ORRaOnDlXZDLRGphAD1R7mh?=
 =?us-ascii?Q?qSpijQLbyz5q8sb+op2rgvWiB9DBb8hJm/8syLmwn7y6s6qZhKty5qVYAe0f?=
 =?us-ascii?Q?m1m9MGhzkoAhMxI3VpQ7UJiwnbrz0UFs+G7XW0gi4kXczJRglPljo0fVywjf?=
 =?us-ascii?Q?9JurPIVn9sru/R38y0auiXApa60lXIpB9hFTFfNVuKbnWHocs/iqz89aiOBE?=
 =?us-ascii?Q?5X8IedIU7LFxY3l0BTXoPUWXoJWPeNONT4aTmbBWTmK+ykITrIx0mv8kxqwR?=
 =?us-ascii?Q?WobCa7JKqdigkMef4P251jx3yElG9fEAQOQY7oHJDccWrN3oLR8ASncFhTAd?=
 =?us-ascii?Q?Ztgf6jGUqt+d4xz60+c0369gJ1al3Mrg7iSgH2FK5ZBITWJVr9vW5/FfIwXr?=
 =?us-ascii?Q?9kzKbRDQ9I+1tTuVUPLMhSwWIrU8u+XbMyqZtZ5gLQuIbVz5qwlDsG/E+1r8?=
 =?us-ascii?Q?Ut90EQ9i6vsddCYHyysleKzxWQ2dTv0WOkIZPhfksYV/21W1NVeTDw72ny2a?=
 =?us-ascii?Q?GBiactYcfydWkplqufqWpcBwOjKhABuxjqAxoQfqX3b/3qlubDzQumJbrTSY?=
 =?us-ascii?Q?EuFPzplAIq4kFZJcSA5LzCVzHfemvgTxR/opgcTkorbQgY0ngjVfQdYDYKBi?=
 =?us-ascii?Q?e474KQoriD38LwohUQfJ0O8dbPHhNjRJGykCp1FPzB2yw0VhVN7Ux3Vzx3DY?=
 =?us-ascii?Q?w/8pKRfafLbTbDcvdfW8/q9kfQ9oUjgx50i32PKoYPqJ+c8CO0TuiQKqkr59?=
 =?us-ascii?Q?r0qAuE4yTvx1e7c0USFnqXxffgVam18vnjG93OSI/VSu23YXMMQQT84NsO2F?=
 =?us-ascii?Q?qg9x5Ds3sm46SlGVAeVLkmBFI7P16hJ8vksZvNYaql7FBmdsSZB4n379018A?=
 =?us-ascii?Q?8kG1s4Ce8efjq2S+3YwE8Z1hRS41mE/5BsnhM36tDGsamk87nl0SGu8J96Sp?=
 =?us-ascii?Q?13RiyjYVzMSGpOJaI0we4LdNUdbZfwXOiNksDpT+gwU1FFh9EEqDxF6AKyLp?=
 =?us-ascii?Q?ydTPH1+8DsCP76aEPa39jj/pKpamIzkkLmw+LCu/9TutwisvkTX7bZUmWlYz?=
 =?us-ascii?Q?kddbf9lomuA9EQe6x01R1nA8GbTrzobUhRX7VKjykRBSDwpQZNCJ8GtC6KJB?=
 =?us-ascii?Q?YTH/auZL5NFNX0uB8Mn0gy+MbSkla2CD4YUme8YGedvP9wAlCodDu20wBAj5?=
 =?us-ascii?Q?eXVjnhc404H/ZOIzZg7mgKnZa13WHTfe/KVSsE3oSAvj3GaS5LzG5yBanz/e?=
 =?us-ascii?Q?+44StxttISXi7hjjTFZohlwy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c424f3e-044a-49f1-0040-08d8dc73449b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 05:31:30.1889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAz2jKDslJYELQ8g8Ie4q0z/u8dkIVkGGe/ZtnDDqMg50uXt410GfklaZCPk7r1EDWytBv3sv78oweZPHbhgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
Content-Type: multipart/mixed; boundary="===============2029516767=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2029516767==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075D7EB6E313D23FAE2732AFC9A9DM6PR12MB4075namp_"

--_000_DM6PR12MB4075D7EB6E313D23FAE2732AFC9A9DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

No problem. Another patch works for me. Thank you

Regards,
Hawking

From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Monday, March 1, 2021 13:27
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: Re: [PATCH] drm/amdgpu: correct TA RAP firmware information print =
error


[AMD Public Use]

yes, I have the same idea and agree with you.

but patch is merged, I will add a new patch to refine it.

Best Regards,
Kevin
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Monday, March 1, 2021 1:23 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Li, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Wang, Kevi=
n(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: correct TA RAP firmware information print =
error

[AMD Public Use]

Instead of hard code the number of TA, it would be better to leverage enum =
ta_fw_type definition, explicitly call out TA_TYPE for each case in both am=
dgpu_firmware_info and amdgpu_debugfs_firmware_info_show.

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Kevin Wang
Sent: Monday, March 1, 2021 10:52
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Wang, Kevi=
n(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>
Subject: [PATCH] drm/amdgpu: correct TA RAP firmware information print erro=
r

miss RAP TA in loop ( when i =3D=3D 4)

Fix:
drm/amdgpu: add RAP TA version print in amdgpu_firmware_info

Signed-off-by: Kevin Wang <kevin1.wang@amd.com<mailto:kevin1.wang@amd.com>>
Reported-by: Candice Li <candice.li@amd.com<mailto:candice.li@amd.com>>
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
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Chawking.=
zhang%40amd.com%7C76e6934844e14fd942ec08d8dc5d042d%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637501639364874702%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
ouIjHlz93nX%2Fj3gZ9tdhHxYX501bJmQm3UzqpDwSJGw%3D&amp;reserved=3D0

--_000_DM6PR12MB4075D7EB6E313D23FAE2732AFC9A9DM6PR12MB4075namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">No problem. Another patch works for me. Thank you<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Monday, March 1, 2021 13:27<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: correct TA RAP firmware information=
 print error<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">yes, I =
have the same idea and agree&nbsp;with you.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">but pat=
ch is merged, I will add a new patch to refine it.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<br>
Kevin<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@=
amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, March 1, 2021 1:23 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.com">Kev=
in1.Wang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd.com">Candice.Li=
@amd.com</a>&gt;; Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.c=
om">Kevin1.Wang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: correct TA RAP firmware information=
 print error</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
Instead of hard code the number of TA, it would be better to leverage enum =
ta_fw_type definition, explicitly call out TA_TYPE for each case in both am=
dgpu_firmware_info and amdgpu_debugfs_firmware_info_show.
<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Kevin Wang<br>
Sent: Monday, March 1, 2021 10:52<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd.com">Candice.Li@amd.co=
m</a>&gt;; Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.com">Kev=
in1.Wang@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: correct TA RAP firmware information print erro=
r<br>
<br>
miss RAP TA in loop ( when i =3D=3D 4)<br>
<br>
Fix:<br>
drm/amdgpu: add RAP TA version print in amdgpu_firmware_info<br>
<br>
Signed-off-by: Kevin Wang &lt;<a href=3D"mailto:kevin1.wang@amd.com">kevin1=
.wang@amd.com</a>&gt;<br>
Reported-by: Candice Li &lt;<a href=3D"mailto:candice.li@amd.com">candice.l=
i@amd.com</a>&gt;<br>
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
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
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
mp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4075D7EB6E313D23FAE2732AFC9A9DM6PR12MB4075namp_--

--===============2029516767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2029516767==--
