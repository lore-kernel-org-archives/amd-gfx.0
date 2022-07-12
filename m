Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8DFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 13:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9563C94954;
	Tue, 12 Jul 2022 13:57:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0430C94958
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 13:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlQp4VgTxeQgU5JSYADPEywJ5PtuJ8Ze8XbWj0UG0Djbf6dFEuoW+FBGp7YoOwGSJDvZrrAmS2ahVMe5Eu5RQSy8417BM5lfkPaKgJAnPJ5iU+omDjih9LTa0PRPsLe+IFVB5B1aQM0RM6WyPFh+BPT4tOdKNRcjQ1MqxPFy8UGdUcjJj9RRO/HjO9osfpJErQDrnodN3ce0q3cXO8g1IUarxT1J7lIaZFCCyGO1hNBdrKiycsIRPxvt5hPtdHgwU1SIu+6exr7qNTD4Y4sg3MIlf7X2SAWMutwuIVdz0UJakpQ1PXfKGsXryvDIJwO9nvoudrOnXPTzB3Bm2OAdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoWwQw5pbkMd4WJvZxKF9zleEKRwN4wfq97UfJwOMS8=;
 b=lQBWNTc5DPZw1KApCHN2UYFJvfDEwiyV7mKd0SVwLs5QD/pG0h4jXnv4FNay5xm48ybmmkoOwD821jXLhbZyAzx4ej5SfoepQt0fKrmyZwZGmtvDPSu/snwsiFMrOmQEt2uytdTJixAv6HvpZbTTe1+hftVOfn8jppqZEbs9ivdVmsypNYBHEWcTl9RrntJm6LSto1cqYwZTPs2wW3+CBThlWM6sJzxjkovS6wCDXHffCns2m7AWP4imSn0Y8oLFnfYPJlRoj6WA02pnT5uDiSZuCUqOTFfyKGetRH0zIi1l2rPotQCpHvnnce+v41RS0OEObId4Qib4ym9btVBWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoWwQw5pbkMd4WJvZxKF9zleEKRwN4wfq97UfJwOMS8=;
 b=HxPcXla9qhEZrLqOU7WowVfg3Ez76Yoa1zohR8coHujUusqS407KPIeHXDmT7Y31BaFoIWG1FVbevkAXF9X1Cd50l4gMa/WZzwSpCz1NuPjcCHNqLIrAiX1x6qlFGAvxijl+dW/05vp8weie76rRgEaw74yazHxMW/JU1HX4XAQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 13:57:23 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:57:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: bump KFD version for unified ctx save/restore
 memory
Thread-Topic: [PATCH] drm/amdkfd: bump KFD version for unified ctx
 save/restore memory
Thread-Index: AQHYlVX4pe0E4joXb0WhmCkwg2Mfjq16w80g
Date: Tue, 12 Jul 2022 13:57:23 +0000
Message-ID: <BL1PR12MB5144B5BB5BA660DCE16E8B86F7869@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220711184153.135021-1-jinhuieric.huang@amd.com>
In-Reply-To: <20220711184153.135021-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-12T13:57:23.324Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0047b35-b9db-4768-dbb7-08da640e7266
x-ms-traffictypediagnostic: DM6PR12MB4138:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8/Dm3RlujwJ6iIrUyJsQxTzDg4Oi2UAucGE9YjpRr9MV1dKezwu785B8ZH0m9S+rJMN+GlQtmSOWJWRjoVd8nfgHXqycblJrVfhji568+vaXGHFqt9c2LB7ARB6CXN0mrxaLFW63bQ1MJ1sllZtaSObELgmJrWprESA267nO00gJDhj7nbTgSwpOsbxzB0HVmu10D+PiUdQMhp+DDws9Hcvgd/UVNSasaHwgthDx2Hv7U8aQKxMrR6Qe3py7BT1aZeT3sOOZk2I7UJqJkr+xSGppBigqcPW5ZKl8eYN7bv7f7aCrkplNLF4n4ifeC/CSJWEPpgszjNjm6pVPDqAifHqR8Lrk1TcRDajTLb6uktwtNCIvnPYad32GC9Wf4tAUT2sd+BYQQ3FaJPozrDYb0laKYAUm/rbqi+eXgGGbDY3dH5/AuMgIE37OPyF7B+rwAK04R4SfcFQOZ6ZABDLvYFEB5Dw5bLBxWPuvIqcrG6XF5o3/t7ujPG8i15Jgcjo3NS+5HlPfF7jQ7ldQJYMnjEHfdGyCgqQIGdvM/HKoBw0EfDJrnXepF2DojdAECbcMDGRd1dTQlnOC64ic1lBYQtMnipOVjCB1AswqzBRqMNrvtHuen2QB09o4IYU9toIDGqSKNyU4WYd9hlrFuHePYYES7yywjKpBi/Watup7XmqRh4C7t4BC7FSey8NM3tguXhyYIfXY8DA1kzgg3JsKx65cWkVb56JdCZgpK8LCOHHdVvBkq5TJrhe92KxD7bJzLzpwOR14nG/SXp1nlAysIr/aZjUrokB0D3kVQpQt5I3zmWHkYJWAFtx7J2Pv9Vj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(9686003)(316002)(52536014)(33656002)(5660300002)(19627405001)(110136005)(71200400001)(66446008)(478600001)(8936002)(8676002)(64756008)(4326008)(66476007)(66946007)(66556008)(6506007)(26005)(53546011)(7696005)(186003)(86362001)(41300700001)(55016003)(38070700005)(76116006)(122000001)(83380400001)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B74jVCIQRu6rvxLzASGSlD6WX5f9abmXYKr9dI8c4PtvJ5mN9cRSZ83EEZ/Q?=
 =?us-ascii?Q?ZjWOf+kVhForg9Li/323DPqcsCmVcPN2ud57AAKurHMu3d0ud8QZo6z9JzfC?=
 =?us-ascii?Q?iDR6Vt1NPy3RWJyjMkdr3p/66zFUBy+SnTW7RD5NNb4I1Gs/+O16/slokBp/?=
 =?us-ascii?Q?B8AE+MVz0cIAwT4ePiKMHJBBKv/jpK26UuoegguFjyPYYnEA+Aa3f4O/mxmP?=
 =?us-ascii?Q?4juV3LstCzWhlLgO6/Ik0j5tyt0NwVH5opDO49ZgGYDj9wuNbA2S8SItA+nT?=
 =?us-ascii?Q?jJU9h0XlhSnOexZ7VbZgx43hSQWePGDpkK0PCuGGkNAe5ALOqW8QkqulSYFi?=
 =?us-ascii?Q?B9fZa3dmxsQ0Hg0DF4WFwhmLuwx9rXrMuFZm+I1RHXEVkec5LjE2Ojb+AIm6?=
 =?us-ascii?Q?GjFsyAyNbQthGenOsZCfQ0KL1jMNu6ADdeUVaOkEIk4ZJzzwZAZCTTyUSqbG?=
 =?us-ascii?Q?3UlvEys1fHqK7UL8ZqMq/pEo1HWrnXBkZwd5Fk73Ktu/3u870IT54CzWAy26?=
 =?us-ascii?Q?ooqffPeHpK7DOHH+BQA4hn5wyQGs5Rzm/bfkosGU6D1u36Tb1B6Meb/1vTs6?=
 =?us-ascii?Q?9R6cPfDLye83Mp/nBRSCLjh31Y+Gd8tlDNaBUp7hWHun1kM/pZ+8S89RPx5V?=
 =?us-ascii?Q?4AAwPCwVy51ZxsebLMIpjvAfqQSqu9lK/ZIuQW2NT5ps8gAoLS8ngw9Yi10g?=
 =?us-ascii?Q?ldTgIsF+hkNyIH9azkaY97I7tU04JeLnS/TklQ9FEu4LPgEZjtDGnpaksQZo?=
 =?us-ascii?Q?CddL00YmoEFD61SWTEuNTHwQFW9/S/4K/isSxE7HPA06JzHMjluFVah0gdKl?=
 =?us-ascii?Q?fPF+q64lmI4+QQbhgw2G0mtvIrLAERlsFUOcZLIud0F+ch0vLOwd7XOWcHvq?=
 =?us-ascii?Q?EykaZ/19tcAeEiYbBOx981QyJzaPscoPZIBegeAYmm7UkMoOvbs/VpwQ0BH3?=
 =?us-ascii?Q?davErG8kIbftvDbMym5/byCNFhRExK0b4WOOzUcI7LrGpiaqcQ8HR6KQSn1a?=
 =?us-ascii?Q?JvX7nELRhOdnL8MfkFM66gzds0YCPoWgFVaGE3Tt7dCjrzNRkThJFa64CE6N?=
 =?us-ascii?Q?oTYfXopXOHhEwvanwaQ/rs9vtgpEAOfFBM26mUn5+6s4V8hQFDlnTH/QyigD?=
 =?us-ascii?Q?dVExXBoOK18ldeoKZWjG0KQEW0JkjIGLD6Mr7lKowdAURvbWt7aJM5vTpYrk?=
 =?us-ascii?Q?n4JyeJ3U4E+djsVp6J0ueZlMBYYVUr/qjL5dnYsfE51Wu62yg6/w3fWDGvaq?=
 =?us-ascii?Q?CaM409+EXZcrgiCSbViG5uIfiDfGJLmKVU27iIF+1el9YhmUYsletYb6i8yn?=
 =?us-ascii?Q?UgMNQqfYrIY2kxUXIvh7bQMBMDjYv3VZN36jvfVU6BEIYss3iUvFw13DzwOd?=
 =?us-ascii?Q?S/aCtoHcI4j7Nk7Iv79nxdshLOFqWfT0roo/5B36o+r2/7TWzYTUhDI+j6J5?=
 =?us-ascii?Q?g8dSrId5SnobdM+LDHEuh2VCmiJoUue4ZNpA7x0sR5CtRIERMWGOAJirzOGk?=
 =?us-ascii?Q?RHk4ZN4sxo6qxDfvzgsnIpJcod68YOZPR0U6tw7q/z51xbrBrUCq0a3q611B?=
 =?us-ascii?Q?6ACkYsNkWqkaN35WfMc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B5BB5BA660DCE16E8B86F7869BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0047b35-b9db-4768-dbb7-08da640e7266
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 13:57:23.7854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqlDnRYENB/SmRKcEORFdxBuWaS2tBXRSr8xk0AS8xHfBUAIuMta9o83mRiLSeo2bUkfCM09phPqnYBgko87cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144B5BB5BA660DCE16E8B86F7869BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Can you please include a link to the proposed userspace in the commit messa=
ge when you commit this?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Eric Hua=
ng <jinhuieric.huang@amd.com>
Sent: Monday, July 11, 2022 2:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kuehling, Felix <Felix.Ku=
ehling@amd.com>
Subject: [PATCH] drm/amdkfd: bump KFD version for unified ctx save/restore =
memory

To expose unified memory for ctx save/resotre area feature
availablity to libhsakmt.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h
index 7a423855a86e..afd8ff29c74f 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -36,9 +36,10 @@
  * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
  * - 1.9 - Add available memory ioctl
  * - 1.10 - Add SMI profiler event log
+ * - 1.11 - Add unified memory for ctx save/restore area
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 10
+#define KFD_IOCTL_MINOR_VERSION 11

 struct kfd_ioctl_get_version_args {
         __u32 major_version;    /* from KFD */
--
2.25.1


--_000_BL1PR12MB5144B5BB5BA660DCE16E8B86F7869BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Can you please include a link to the proposed userspace in the commit messa=
ge when you commit this?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Eric Huang &lt;jinhuieric.hua=
ng@amd.com&gt;<br>
<b>Sent:</b> Monday, July 11, 2022 2:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;; Kuehling, Fe=
lix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: bump KFD version for unified ctx save/r=
estore memory</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">To expose unified memory for ctx save/resotre area=
 feature<br>
availablity to libhsakmt.<br>
<br>
Signed-off-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;<br>
---<br>
&nbsp;include/uapi/linux/kfd_ioctl.h | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h<br>
index 7a423855a86e..afd8ff29c74f 100644<br>
--- a/include/uapi/linux/kfd_ioctl.h<br>
+++ b/include/uapi/linux/kfd_ioctl.h<br>
@@ -36,9 +36,10 @@<br>
&nbsp; * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs<br>
&nbsp; * - 1.9 - Add available memory ioctl<br>
&nbsp; * - 1.10 - Add SMI profiler event log<br>
+ * - 1.11 - Add unified memory for ctx save/restore area<br>
&nbsp; */<br>
&nbsp;#define KFD_IOCTL_MAJOR_VERSION 1<br>
-#define KFD_IOCTL_MINOR_VERSION 10<br>
+#define KFD_IOCTL_MINOR_VERSION 11<br>
&nbsp;<br>
&nbsp;struct kfd_ioctl_get_version_args {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 major_version;&nbsp;=
&nbsp;&nbsp; /* from KFD */<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B5BB5BA660DCE16E8B86F7869BL1PR12MB5144namp_--
