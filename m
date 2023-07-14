Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99287EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 14:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0CA10E8A8;
	Fri, 14 Jul 2023 14:32:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD12A10E0D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 14:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDWPrVBsQv11bfSH1y0TpKwKgi/uOTDzl8Bz1bRnGolV5gyagC68gbCjD1PgFT4xNsI9WIJVs+Df/LmDSnO901drajF2XTP+dKIMkrG2J6RjNCfynPYLLToKtUdS5LX4g71P4KR77w7Qe3EdQVJsA77kNAmz5bK+5XNGXjWCPiGBBTiHMBhIDoYRDCE507ExzEqt1osE/AxhNZ/02jdeP+RmItiQCxCmhKHYKn4CI9mEbPqeGQMQM0hggOSDx+Db4a8rej6CeMDnjKSZjVHoaFOZHO9RaDRTJ5qj0MueVA78zEQAYkYL2Wl0OaBUIhn4QMPMlWdQNWsu8O6eCBT8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvQvbm6nFnWeLLf2vx4++ygDLssUhry8Qpe6LuzQWxY=;
 b=BSPuLBQVjO6eD4/m6tZ5movuXTO89LtjAWR7i22OrNmot5UKSXRp6PdTRU05cb+79+EGUs4AxhVPgHm/w2hno77nNUA9l4M0EqG1XSZhDMF+D0kUrNKH1+AJzLNON4G0lGWS7c9LwTqRhTNBb7OlN0k87Df2W67WH3RNWkdIwmcvpmO+4ZjAirZ8lTqsh5tgz69XZZUAqV9fqhYIKhYUaHV2le7DgRFZF4lVNVDlWYRANod859N850m/yQnXFhS7i8XJ7rQKdzoB8EH9xPd+v3YA7fnWhg796YPTGVFBrUv45mZBu9C8Ru9ZpZewLD3eX2UketxTwak3mTvSUA6HSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvQvbm6nFnWeLLf2vx4++ygDLssUhry8Qpe6LuzQWxY=;
 b=0MyCpAQ8HZw1s1oizmlk4I9Ik4aVDEB40WEGJKYPwd+lQAHiMEEoCwiFOdytELtDgHeQSoGdSp0Kn56Qu6mi7o+qj2z6vq5V+SAb+8M/xxnJf4egwEGntqM2Ys49OD5JC2n3Fh8IXlL2/Tqmv/KRdd7v572xLQ0zrlewbuXHOtM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 14:32:28 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::40f1:a67f:11d7:7395]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::40f1:a67f:11d7:7395%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 14:32:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Allow the initramfs generator to include
 psp_13_0_6_ta
Thread-Topic: [PATCH] drm/amdgpu: Allow the initramfs generator to include
 psp_13_0_6_ta
Thread-Index: AQHZthXZCIWtsEifvUuxMFQ2hON646+5U8db
Date: Fri, 14 Jul 2023 14:32:28 +0000
Message-ID: <BL1PR12MB5144C53D92B4BC4354B2A28FF734A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230714054101.85866-1-candice.li@amd.com>
In-Reply-To: <20230714054101.85866-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-14T14:32:27.530Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB7780:EE_
x-ms-office365-filtering-correlation-id: 501e47c8-cb98-40c9-6c26-08db8477266f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdlITcPkBIIiFcLMtuPjB54NkqG0lLDM5sSim8ni2Ztq+lgpnLRZgAy7VRHFjefBtaBNZ3QxiYnwmdaBN9C9YPl7fh0WSFaBFABUfmyyemfXqvW/VBzsu/RYez7w2TNCr1E1fh3/Hl6gRUWL0uIywidk2RDS2HCsleXlYzzmsmWYTTnF8HIvFgSNpZPM0BVFbzccamjgIdKa2+WDJEi1ETONk3A0E56nE9bYrOpWW2/gQj10yJ4PgDVaebUhqF+z0NJzQOZPz2TXgwXN5+0I0kSappk7N8YnTs/rDR5HGJUoj34y0MJyzgqT5ff7ArTYaVrxvQOkZRa7NlcN2ve86DaM+XzJe+r9DF+Re5yNN/RIksblZ30FhBGBZA/5Blq1mevlcE5K3IcrAC4wDe0R7tqvgSFZKXW0Ewtx0/k4y+BHsDVxnFPX6D6qbrqst9EQFEKbemMl4CAxTztZ+PrxVQE9Sf63p7VLgm5jcAZRylsEj+5BHPE4lkZRhop1/KtmWehMlZjQIwp9YrxKOBWgQaUS4I3uZooK1L508N0wOdsn1T40VAbM5F+jdEU4JjybPKRlwV/QHsrM2FiimP9EgYo26WaoE4zAhYIypb44brLKy69bdvu6XkQIG4Uo3cY0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(83380400001)(38100700002)(55016003)(122000001)(33656002)(38070700005)(86362001)(110136005)(478600001)(9686003)(7696005)(71200400001)(8676002)(5660300002)(8936002)(52536014)(41300700001)(316002)(2906002)(76116006)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(19627405001)(186003)(26005)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JqzNjY1/oOWF6VKA/0TVZ58erGk9NCVX+7pAfL++6OPDGHMK2mQBY4qtCl22?=
 =?us-ascii?Q?c5jTiWbqFTgnL8vvCZ9Z3wup1wY6DSY9cXFhQ9cOCtYvZw06GiV9JJWZ9VHh?=
 =?us-ascii?Q?stDKNx9qdFly7xuX6Ki0vmbVestpqEEAEpA7mkp+uTIGWUuknnywAtpoN5Zz?=
 =?us-ascii?Q?PcOYqc1JzenMRsJ563EipFEo6aprO36eqsFXU2t6t3PU3wgyGgiYN/FBv57O?=
 =?us-ascii?Q?XUTnrcQ6vSM9AmqVvE3rEZU15ShAZinYxtJPI5jjM/vdzTt5RNh0OqceHtEu?=
 =?us-ascii?Q?Oo1aLyAewXteWO6mKTMIZwNnCGbCYKIMq2Pd38ppozQIMM6JercXW2LUFEhK?=
 =?us-ascii?Q?vwxoNLcShJaodumr56Tsdl+OmFsmNGZzhEjmVovunRSrB7tkwzjADwFE0llH?=
 =?us-ascii?Q?2NAvZ5R8srSPDvGyLMqlW/GTKo0wDKKXT0t+IKEv4icHYYQ4D4dHC9XWNpGA?=
 =?us-ascii?Q?MIGNqCmHagrMlyVMfYFk7cmzsoi7zEAJXpfp5yqiqe20phirXSYbhF+JyQwM?=
 =?us-ascii?Q?XAciOp2ARrDT2BDQpC1t4aRDKw7G8skwXlURe5+Tz6e1m3aH8SlJGvbPYzY6?=
 =?us-ascii?Q?g3a7HaUEs7uqlLNZIWI4OiAU3IdeltXQK++K1Rwm+vAnHy+adbpSSf3d2qVt?=
 =?us-ascii?Q?/+ECGTYMwlJP/5EuYRRXrZaYAX0vqpki1Gdr+7XP8OlM5g9etVwj2/uEazOx?=
 =?us-ascii?Q?JLuDkDtvi2Naab2Ml64icuTYeyIIVw3F5rX2E8PM8L3HmrzzMs7PrQnROW2h?=
 =?us-ascii?Q?vFSEOK+VeTIVUBbCM8S4QjdYIAhqe9UJU9zB8aObFbsasbmVqX+yFTs6yj7d?=
 =?us-ascii?Q?V4iR10zne3sWQEJD0R9toi0zcbSuVqKYH4uLBCBoryGxIFPalDALoeE0Wb9a?=
 =?us-ascii?Q?hdsMbWfzjVX+jndu2QR5E1BUJvup6K+jvVCWF9iAmKAzYSeC3Q/m0Kw7wyHj?=
 =?us-ascii?Q?NCslPMF5+9FOm7pYHhoV94JNzfvGMdUiEp/PAZmhi1BNJpbKfkjMFXzcKvp7?=
 =?us-ascii?Q?+Ad8YQS/L9xPv+TbB4J1V9V1EG29+akgFk9+scU/n3zcbR2aWRSbtU4LE16I?=
 =?us-ascii?Q?11IJKnGxlz8y5lk+GIfDPiXJjQKTEVdatW5NTJqatLewNc8pOfYRxVhX70vK?=
 =?us-ascii?Q?H2zwxF0xva+aiqp2Eco1vH+3W5KivXDSzDCcLu9oSnaram+Uy46if0UdFZ9F?=
 =?us-ascii?Q?JfmVGTqOjuCUBP84cTbVI0baIQL7yoOEREz18RKe923mNKQnGX1yec7F6NRa?=
 =?us-ascii?Q?B+kNDQcmgwtCecx/IBvxmm/sLnu2hCv+xoAtwuRuCUtTdHWRonjsA5u/aV7n?=
 =?us-ascii?Q?Uy+j8NlXrIiXtzB0dKIIBnfNT3ByEbmiYMkeXq41RG16B0DIKmYEwtYxH9kH?=
 =?us-ascii?Q?0StuTTjzGWJXvhpWoFn9SLJxarRs3JgPh/9YhPVptI+L5T53PEeFkyhjUZiN?=
 =?us-ascii?Q?AAKy8Qsut7lXe+J0uBQnKfyvjpEiUbYuPphkTjEvQyXKb6dqQdvhRN22egWv?=
 =?us-ascii?Q?/24LLNpsZbcvXSZYrVj/1UAdTS5JXKTFbiiaZDzC+Da0IOK5IZdSVP40xg7y?=
 =?us-ascii?Q?uUteFcKJYXQBRVDwNd0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C53D92B4BC4354B2A28FF734ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501e47c8-cb98-40c9-6c26-08db8477266f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 14:32:28.3420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEE2g0NiHVYqml30dj9kZhCC8VinaNUNpxxBmomQEcyILRcFod14yR6xB31FvNIlUPZYNbwxVav0lnyI0h41qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144C53D92B4BC4354B2A28FF734ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <candice.li@amd.com>
Sent: Friday, July 14, 2023 1:41 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>
Subject: [PATCH] drm/amdgpu: Allow the initramfs generator to include psp_1=
3_0_6_ta

Allow the initramfs generator to automatically include psp_13_0_6_ta
firmware to initramfs.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index f9cb0d2c89d15b..e1a392bcea70d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -49,6 +49,7 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_10_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_6_ta.bin");

 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
--
2.25.1


--_000_BL1PR12MB5144C53D92B4BC4354B2A28FF734ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;candice.li@amd=
.com&gt;<br>
<b>Sent:</b> Friday, July 14, 2023 1:41 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;; Zhang, Hawking &lt;Hawki=
ng.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Allow the initramfs generator to includ=
e psp_13_0_6_ta</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Allow the initramfs generator to automatically inc=
lude psp_13_0_6_ta<br>
firmware to initramfs.<br>
<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c<br>
index f9cb0d2c89d15b..e1a392bcea70d3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
@@ -49,6 +49,7 @@ MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_10_ta.bin&quot;);<b=
r>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_11_toc.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_11_ta.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_6_sos.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/psp_13_0_6_ta.bin&quot;);<br>
&nbsp;<br>
&nbsp;/* For large FW files the time to complete can be very long */<br>
&nbsp;#define USBC_PD_POLLING_LIMIT_S 240<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C53D92B4BC4354B2A28FF734ABL1PR12MB5144namp_--
