Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305FDEE7FF3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 13:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48BB10E8B6;
	Fri,  8 Sep 2023 13:24:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE77810E8B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 13:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPbIDgO+wWsYpKSDAnowjj4R5SzR2noAq0dGN8RQBj8fZEr60iYkzTdRqeCs6EEG+z/vZVqOxd/sJgRm8Hjs61NRQ4fqPSqSsD9yHAWVbb9d1XN98/v/1AArPEzx6epWDVs8llRDqBrPkzZ3dHrJcmhhCVgtg6rQ4DuY6tuk/4+U1Kb/emJoS8Hu4qAX4UBGB03lu7J2zG5S9PuUbUSyQ9RRSx7PgvUUfsHseJV22G5+PoTmxKCfMp6AImQ1PnOBLrsaKiiCtSF2/9yjtRKgD0A95t9Ok6XTS33akNwvVplqHPTepQbIa97IkjCco5ANuoYGuK8KM03o+y91fLiBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69rOvEkMCzB3JgayRq2dWjQDink+J3Q5vX1tlS5qhig=;
 b=GSssUXkH5C1x2u9F4xlzOR0dUw8btS18SLlSn1YRv11ieIN8bxpiBn7LYso2kFHX5smlQ8ldK5/byeao0DBT4zWS57RYHqS99yC5a3WTKCZitXPM4Nsd8+8iSp1bMWEUmapA5EhrjgrG7Rt9ReBXV/Kak2coZ+krJGPkvwjzdqroE6TRgBea+k1Ruyq9378HRcpL5IuC4GUS+jcLUAKVH0U3+WRfurjHbGHALL1kgExCoY/S33gvyYu3NPjcr/WUOsZUXLZLfa5JiUxPh3ZuUAt+1LoyRCyqwxSc26O14YQ9QUZGHiqbnmzqzS/GNvQ1Uq1l79zDL80rcgQrh322PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69rOvEkMCzB3JgayRq2dWjQDink+J3Q5vX1tlS5qhig=;
 b=b3L/okQtYQ7Ez6fwfJT7eHoL2zQoqy5DFxLNd+tkob65mMdFWz29jaFZTYyso+AiUyVwi7wmE6pz8Zie7HKtAmcMzqE8T5A1/rtVB5cabopxFep36IU7BC6vIqdTIcTpg8/nwINI8f6iPHemnfOtW4VB0zBqDgu6n5wDcUTfUgY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 13:24:53 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 13:24:53 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fallback to old RAS error message for
 aqua_vanjaram
Thread-Topic: [PATCH] drm/amdgpu: fallback to old RAS error message for
 aqua_vanjaram
Thread-Index: AQHZ4leSShhz9WVoAk+fA4XPdRKdXLAQ6tzA
Date: Fri, 8 Sep 2023 13:24:53 +0000
Message-ID: <PH7PR12MB59974985766C781266E6C28282EDA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230908132229.9569-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230908132229.9569-1-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=232ddb82-5ade-46f2-aef7-6081c0b7084c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-08T13:24:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB8536:EE_
x-ms-office365-filtering-correlation-id: 73f7f2c9-64e3-4dba-24e2-08dbb06efc8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mD3ObA6SkI/NoD+atsJvi6lWlQhYlZ7YJVBRjAYf7U99Um9RVJXvTVmt9UWAQIcP8n1YEoawF/W3JWj9+URnGJSlfYnV9eOZWqOi5S6PO+AP4gbrNGY8V8UFflC6gPfqGZZaiSUFZQ1wesKQe+0fF7sLYrI7ujdKb7gJUoVRqkNFbuGsRsriNqfK8hStCt2b1nv8Clcf5ZTw2vTqxep3p2jykZgTidOUcRJWONNVHFi+ikaqA2VbB4txByzbM4fGRs3lQsZKVoawZtNmQclbSVHx8tagKyVoixcn8wuybiAaDe4HUx3ubUuhN9643cXxySM0EUXZZfNNQgpHmBTsAfrfcakpYhelzgWH/xZSNJbzLXv+fsK8nzXMkbE5OBpMdnYNwzKEzg6+yFuQZbH26bUzbIgzSehXkrlZJzreepraK874zqzy894bDz0XMv/D9TpVL3Jl1dJm6Y4QVGRbZr/7+c9e8YgjBBQ96LTS3/4zktcAtmM+j8NkanPNDOLSmCwxjjMLuP1+iYmK4uB6W8yksfiGUWtDhRh5ZdQt7m6P+ahpnEJXwY/tW1tvY5CENPolD5nZShaPW71ca53a2AycxVtmNTDnyaFVh2B3825Nzq56GFKlr1TzWTcnI134
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(186009)(451199024)(1800799009)(4326008)(71200400001)(7696005)(6506007)(53546011)(41300700001)(9686003)(76116006)(52536014)(478600001)(83380400001)(2906002)(26005)(15650500001)(66946007)(66446008)(64756008)(316002)(110136005)(66556008)(66476007)(5660300002)(8936002)(8676002)(38100700002)(33656002)(55016003)(86362001)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7s7uKhCVLe1gXYPosb0ZMoZWY0jDtRMkMwFC6xoNhAj0IZ5rt4BbBzPICvWJ?=
 =?us-ascii?Q?Fkk/66nO+QIwLJQAsxKYeY3KUxLjdvjgqt/WUnDr3F2D69cxF3CTVUaehbeI?=
 =?us-ascii?Q?00hfJ8tll3p7zjKqrhXLerZLX1OLs5giSoXXyP1XyWcrPkrzBxsByMF3M4bL?=
 =?us-ascii?Q?W5Ih7Ke01cSCPH73i5lLzCJm5/rFSkR8dNz+I9Hzawrrsajgzs4y7B7Jz/CM?=
 =?us-ascii?Q?gGPBDUerbytb9WezQTK5mQUNU0SBGKHD0NaBpTZywJrVHW0D0SnqBghsrE8J?=
 =?us-ascii?Q?wFEmXAgjt7fyq8JE+gL+H8Xu+PqQgEtj12eo2JFPE9zRKaI7l5t/kw5zQt84?=
 =?us-ascii?Q?VA46d9klhWZ/nHHl/DI3mWcKGtcHUum0y1U+HCNpJm6U5JvB4Yn2fAiwfblp?=
 =?us-ascii?Q?0sdQ1EiscKsHGCTw5OXqR390xzoAtaYhxaGlAOm2neMtFwHl69PK2kbBOs39?=
 =?us-ascii?Q?27Gm4A93rylc4HOn4T5YHiLbT+9yY94WyOhyPjsTcQqrlMPPZvYhFUE9AKGE?=
 =?us-ascii?Q?Ge3KD4+2Td9cXUxgSsahyNREl/p3epcEa2OLJcJhR9rm4p/ZZnTIrwXJtVrO?=
 =?us-ascii?Q?gp+LrHb8g29kdahNpPXJiiNi8QhrwvlCGKwl7LbgKNqI0XfxIZiMBoxrjV/S?=
 =?us-ascii?Q?itFmC5cUFGpXKjexTvm9EcWxiaUokQlo4nqsn5o17yW6qu2SPojsGHJpTOQJ?=
 =?us-ascii?Q?U2oOT/kGL7kiUQhg20SjIK017F3x5Xyhh8/oddLj7mqXB8OuIz8f46+m1wkV?=
 =?us-ascii?Q?EseLr0n3Q3zPgF6GdfYSQ1PUa1N4+hFNlfvxKB1uxPpn7aWYYd12syot1psZ?=
 =?us-ascii?Q?i90w+UpSsy9TqH3rBGDSks2ji2pJ/jWW19LyM//w6mHo9+Kn+4sGZsAYRsir?=
 =?us-ascii?Q?GHnVYXpvDar9F4g0ymOX6cXfCu5j4z8uNGZgq14fI7I10LMrWHJOlYtbjDMD?=
 =?us-ascii?Q?Xdnv3kR6ymc5K40XN6ThU7pj+ozLedTz4x9XaKVsG2sGdNh10nZAb98tZKUt?=
 =?us-ascii?Q?6/laEkFLwBBI/FGaHrSlRXRDw7afVSo9wMgJ122TtCIWHmBWItAXPHdetEpc?=
 =?us-ascii?Q?BZNXJrVf++ZiKHhhQq0kzLXYZtCVy/AQtV4HBZtteHYBo2BzR/B6L5AQTBdP?=
 =?us-ascii?Q?mqXZpGM2PWyTSer83AYx86mb1twBPMAhswezI9N1AeKjB6+Klbgdfi28iyHt?=
 =?us-ascii?Q?U/3g8WmKaFRUOeZfMkuVLKGS+T/jhrJd8BlLloSdZghS44jL3agO78bVWUfU?=
 =?us-ascii?Q?T8AnE6BLXYDQDSByZlAXoBMb/6KGmtCk6qYwJBdMtNq93ysinWSma+H2gINL?=
 =?us-ascii?Q?4U1IjfzUoLusAMT0VqEAdg0NuB0QSnbBoQ+HiX/MSGPaMcViQCqycx8apgPU?=
 =?us-ascii?Q?DbIbyQ5rPO+WyHI6V9e1SDsTeeO8vBivfSV5bTcBKsbUfJDs3+8fGGgWjebX?=
 =?us-ascii?Q?IpirZbSI/a1/Fqh+piqDEV5ybfGPa7RaPkPVvbGfQr9wkNghnY7eKMTTXIDN?=
 =?us-ascii?Q?3RqsSLkzmm8emTeXu0eSMucqlOnFrS6vPG2RxcLNlmIALc9Ui+xlAoKL6CPw?=
 =?us-ascii?Q?O7l/+N9S2FBiyI/91ys=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f7f2c9-64e3-4dba-24e2-08dbb06efc8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 13:24:53.2575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PyT18gcMVo2aZCjeJXCHIEcOYbwKN0Ip08cqvVy11BgafX3vhCCY2RXiXIQ20bH/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Friday, September 8, 2023 9:22 PM
To: amd-gfx@lists.freedesktop.org; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fallback to old RAS error message for aqua_van=
jaram

So driver doesn't generate incorrect message until the new format is settle=
d down for aqua_vanjaram

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 8eb6f6943778..632478874f7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1053,7 +1053,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_devic=
e *adev,
        info->ce_count =3D obj->err_data.ce_count;

        if (err_data.ce_count) {
-               if (adev->smuio.funcs &&
+               if (!adev->aid_mask &&
+                   adev->smuio.funcs &&
                    adev->smuio.funcs->get_socket_id &&
                    adev->smuio.funcs->get_die_id) {
                        dev_info(adev->dev, "socket: %d, die: %d "
@@ -1073,7 +1074,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_devic=
e *adev,
                }
        }
        if (err_data.ue_count) {
-               if (adev->smuio.funcs &&
+               if (!adev->aid_mask &&
+                   adev->smuio.funcs &&
                    adev->smuio.funcs->get_socket_id &&
                    adev->smuio.funcs->get_die_id) {
                        dev_info(adev->dev, "socket: %d, die: %d "
--
2.17.1

