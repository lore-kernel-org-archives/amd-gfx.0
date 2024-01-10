Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDECC4706C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 02:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1218610E556;
	Wed, 10 Jan 2024 02:20:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC6810E03E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 02:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMl6dJLFsTyzqZkPcWd7JcvK1UY6qZCBNAE9FCvzLMtQLo1a23ggBa6r3zqo0fxewxPs0G0Ke2aVXvOCFSGblwO5sLrgzBMjlMWuKtGop+PKKCPWz9Ek4Vb1xHIUSAZoqAdX7otdYJq3LJy81jVI4q08YC9ODc+5hZW3XMD7F+ObJXAQCzBSD5uLIc88awDMKneD5gAdSnB05Kv0K7RTK6dQ0/eUg4lI4jK+H/7xQdqsgVC52LMlbz0gisznU5V25jxe62j8I8BYWqXJTwfrUMh2xuzkUcTv538M698tm1KoQLIu04oVo0d/rtUecxNoob1TcDK7XIwgCqb/je4Ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBBidiPqivRd0dm3Tx1A92xPGxQSkTXeFyTbgB7g9qg=;
 b=bA3Je+KHirUDo+XhCfJkcDYliL7pWqQ4fidbYEBMld54b+Uiqd8gbzdjm4cFPYbcrwXRU1gXtJ7ZXAILUnbhCp8aigOAp0vbxh0XiJBrztNUMtKQwXK/sxEACp2mOMS1P6BX6r1H3dXMNugtcaVJ2XVSA0Wd0v54S1Npl4wAT5B1i0nQwgmyOmNmdzv1cwCMQ3mP8Zz6P80ToKsgDjMkuROpDTNvg80yjb8nh7IqzcBu5mMLj2okAf6WPKWgZOL3vQwJCNq+71znH2UfvSLbPeCpIeYVb+woOOSBJOjh0M8hcv3D96/blGiy8HkhPNixfkJRdJzangAsgju9pT4zNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBBidiPqivRd0dm3Tx1A92xPGxQSkTXeFyTbgB7g9qg=;
 b=EiRf0/qTnXTAcbNkh6mYGko0pHlzMdGzW/dGylT2P++waGPQNchuBA6ts0u+HZFZdpr8JGEtMs8v/YKfVkibHjYNJ087yjImKzw8VaO/IQQT4Nqonwp8ldFmjU0PUMy/rELKiiwfcjvT1IDgJIOEHLwzS+dMQU758fpHxd+YM7Y=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 02:20:20 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::a62:6417:ec34:a0f3]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::a62:6417:ec34:a0f3%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 02:20:19 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query
 mode
Thread-Topic: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query
 mode
Thread-Index: AQHaQ2pX+lsPX2GCzUuMXvvrSk/4nrDSUCgw
Date: Wed, 10 Jan 2024 02:20:19 +0000
Message-ID: <MW4PR12MB6875FB7C80FC667D1FBA006D91692@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20240110021109.88159-1-candice.li@amd.com>
In-Reply-To: <20240110021109.88159-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=58f35b6e-7816-4110-8897-ddd45299a961;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-10T02:19:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|SA3PR12MB8047:EE_
x-ms-office365-filtering-correlation-id: 000f1a5e-f6ca-49c6-0b7f-08dc1182b15d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8gHKrtqjbXGsxhy84jX9DRaiwkjcFc3UZeglWpYfZCmhrbICS9KiN+f353cchvg1A1gD8uUG64xeE9a1JITV00LDF9sInZ8kfSMohNMmQqtwbCSMRiifAfRuBQzR7io5TXf4c6zRRsK62tf/vgHVMG7r/YpFT2MWNHe1qODTfcMpV2hwUCd/JvHJY8uAHwnswVSE89++4oF+HSW+UlcEhr6SjGJaoz85xs+6GyepgeZbKWn9NtTMLyVnNhRrLGvtMmnqsm45APaNGuscM9EZarMwZSiS1dM7Ac/B2QFTicnrk46+fBmCuLq2oGraNtZs+WDcnMbCJWpxYItkSz71iz32wdTWbtufMNRwIWgWpOW83ionL1GhrP411qX6hMYl85tKsdFOzdRAejMmFoHQgcIken6/4sCOq4Xc2RC3RMoo/sy0t4F9KN7wWtmRjo2b4iz9RRQPnpBGjNhP26BH9hUcF9DaKQyT6P4sPksQ1SX2LPKX+ENXEN2Ck974Nm2RRuUmckYGtfVWEvWDynrfNQRqGTVw2VGzn7ix9cDU7HWG2UGOyJamrL/Fb3H15Jd1eFYl3zPqpYlJ8uG0LVPjxQ3X4lhDAPt6SLdm89CzNkBrDhdDcWSM8wfC8WGCloO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(6916009)(71200400001)(64756008)(66556008)(66946007)(66476007)(66446008)(76116006)(7696005)(316002)(55016003)(8676002)(9686003)(6506007)(53546011)(8936002)(5660300002)(2906002)(86362001)(38100700002)(41300700001)(122000001)(52536014)(38070700009)(26005)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YOV0lF6gF+RKOX7XbKtXBPKhe00+aqNGP/lCj9Lp3nNMBXwRdEI7hO/eubt5?=
 =?us-ascii?Q?WNFhBzYfLrEpZcEVqYBBbHK+DnIQ7442m0+QfZ38pAudYGzD0Xw5XuulHwad?=
 =?us-ascii?Q?03UYIhiliL3rI2qLPG5yqRiTLq5+sQLK/+SWqqQ3uzRCNYfG2yGKNlMz7slG?=
 =?us-ascii?Q?vaM+wBTfriRyz+VmT7EDPzJ8Gz0qvcmZlY9mMmwt7b0lFQlAExF6O0jVDlno?=
 =?us-ascii?Q?wuMqFjIZXjmX7VA4UQ4ZJ/IgrMbL+Ba+Vk/UqslJRIDgNYP6nxdy7uC7lXdR?=
 =?us-ascii?Q?ak10FJVp6dXRbJVTqH50BFLImoZFhlxHagVMNKzLxDcKs9m58osxdcUMbfKA?=
 =?us-ascii?Q?NG91fAe6JIK4lBCHrOMz2ziJWkTtDNQ+1NxbhL8dmvBt3HUoKffRXlI9cs2Y?=
 =?us-ascii?Q?8Zno/wsIAwW6XW0Vm2uUASNlytN1O0M0JnCVgQLCCVBs/kLBAu11alq9YVDj?=
 =?us-ascii?Q?YurqfCb1UoB0Bg3WmzpsYsNd1vPTAtJAcs4WMof1RpYhnpjjcJ4xwfInH3WR?=
 =?us-ascii?Q?I8uylNlvIB/eGCPxIRvKk6PRDNc7UPdUlqGcIDtodVUOaDu7ivVqcYjHoPEc?=
 =?us-ascii?Q?0CJhyljXpHkiBH5WqRKZAYgKZvp8Lg4fBTW0HBMDLrMMWOhyLMQHA/pRUZLy?=
 =?us-ascii?Q?2Z0SfrjLct4sMLEXeXhFzIz2XXRo6iIAVyXo0Um2TafRH9AbHL2z9Be2ZC0r?=
 =?us-ascii?Q?CeKyV5ZQO6x7uvxyRs7OADUmfBonQ2Vj3zvVQasoZ8n2O0BmaY4hN7F7UQdP?=
 =?us-ascii?Q?00ebQHbCPgUq8ldxsH2Uf+VKuR+6qkYcyscZ0YtWTPnSzkobwZiMR43eTj51?=
 =?us-ascii?Q?gkpD8Ujs6xf05/kboa6pPG7vaM5GKPsDM7VQ7+8wSmWPZTgW6ULl5H8/X0KD?=
 =?us-ascii?Q?i7jBzCFeAztf4UcPb/W3IWFohXcaHhiuou4oFt+4E3Cktn7yoB8Fx/ut/TiJ?=
 =?us-ascii?Q?1z7BaarSwY823FAANsm1easyYKfSpeuAsmX+iBBnoE+JxlfYMXqE79prAXIE?=
 =?us-ascii?Q?9zCZpfuIiB6p9QrmUDoEFA4TO7Z4ZsvruO/zn+/yUU3zlzUZDwY4z/GSavQb?=
 =?us-ascii?Q?oO4FgPErmEPg/Izj4YZNzYzmSSWwIGnrEp/a9+kwJJr1nlq9qo6CuG1nWiE+?=
 =?us-ascii?Q?yQlpKzl3TSEePizVKf0nvZJoW5pe+bjVsciTEDrnui3uNXjcknJCPdo5V718?=
 =?us-ascii?Q?B01HbykqTDxyxVjNqbx/PejA+Wsr0x44zCqu0F6KzKU3/UuELEV5D5fQ76Vy?=
 =?us-ascii?Q?JGvgJdrn7P5kRphkN5g6jzD58w/lRAY0CCI7mJsh/D1FrKOpz1rssULqprRf?=
 =?us-ascii?Q?hvqLcNgKIpBxhmuDfBhTTadVGckp+xOujtvc1XmAXfV1+cmq6NX15Xof6bjD?=
 =?us-ascii?Q?UgdF2ORp7GNVdgso0V46ukAApXfTjzVOwI0bGEeChAKJcWjfxxrqRCWw3dB8?=
 =?us-ascii?Q?WVagPOgFGMVxQVbE83Fk6rRigVkU/Wi/2Iyouzza/r9KbVQIE7BJGl4EXJff?=
 =?us-ascii?Q?8bggDh/AVcQArR8IGAIScwjfhE+l4wbXONeAglbAAWUEd2LZeFMTaMJmckoI?=
 =?us-ascii?Q?mZ8hOqDbeqKvKm/57Kg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000f1a5e-f6ca-49c6-0b7f-08dc1182b15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 02:20:19.8252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yv2mxapfWACVRPTloTjq/T7+8jwj80mKrOl4VCehhl+gbUX5ODo236Fjfc/puNGC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Sorry, please ignore the patch.



Thanks,
Candice

-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>
Sent: Wednesday, January 10, 2024 10:11 AM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query m=
ode

smu v13_0_6 eccinfo is supported in firmware query mode only.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ebc6b421c2cb4..8f78294e4a6195 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2896,8 +2896,11 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struc=
t smu_context *smu,
 static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
                        void *table)
 {
-       /* Support ecc info by default */
-       return 0;
+       struct amdgpu_device *adev =3D smu->adev;
+       unsigned int error_query_mode;
+
+       return (amdgpu_ras_get_error_query_mode(adev, &error_query_mode) &&
+               error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERROR_QUERY);
 }

 static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
--
2.25.1

