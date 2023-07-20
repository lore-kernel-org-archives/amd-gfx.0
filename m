Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF564EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 05:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589C710E554;
	Thu, 20 Jul 2023 05:42:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E287410E556
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 05:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOu1OfzfozqzRLE4JrfiB3D7rojluCBkfAE42CsYreW4hfblqeU6HXgXZzsVTA52UTuEjekyDiB27w0IJg/EefPhW/czLwoMrsV8GYsn+YxXpyfkTrEOiJ9B+SDYkr8If2XxFH1eaVgScT+snZdz/EAafNPWR2p0RU9Lv0ju51AIyPx8Eg6lEg02WfdbcbgRo3MoRYaD8aPof0VgL0yNktNPE+QRq5TjP4dXJRHS2rfkWhF+qGMMeQM6wfriZbM3pCS6DX/YU365ZQPRVX0TsusOBWemf9vsSJ44cxyf10z6mvNM9GCk1/p/kwezPGnOgtgG+UOjVUAgHmDdudce7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFZ5B+cScarHOn+JHYVRv7yp2x9QEErUcYff+xcv3xw=;
 b=eFdZbLYRvXTzqOEEHIZfP5Qk+ql/YTyN8sUh+ZzKq2kHM0VB+m9J4bpqZzaA/0+VxrIBijjRwORHikwJAc/rFIOtpvqaC8h2gbc8QZ9gXZ2iO3PebV0EV5VpCYPj7FTFHirKOICuOkgxhesfCH0lEp0VidBTSOjZ1TrBPYVNdiFg0My/N0lnszgY4y6ihznYJV9GvBKauPzXSUeTnU3rotq3WC+sMz/CfzZhdm4NiiVb753hpnj4OV8a4TkTv9f121V2rmjbLYIhFdhT+2QAAYP0zh0xMElelbXfVhQ76mOhOp7eDmKdVgfk+2eZUzas7vzdNgsJsHiUQ1mOrQINAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFZ5B+cScarHOn+JHYVRv7yp2x9QEErUcYff+xcv3xw=;
 b=D474+V8PtOHSYwA5lU2e0fmmyrH6GzYQWWbBzAgl8P8Xu2wew0qkWi/EdYUfv1RAiUInUpX5hLbALxWKKkvTp3HrIIpoB8nMkgjP6qVPakdyQ1TMR5PT57bv48j6gkqHWp4QAdhoHEx3gN7mTroEnj31jU5pZI7Z+ppvB8xehjc=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 05:42:13 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 05:42:13 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Program xcp_ctl registers as needed
Thread-Topic: [PATCH 2/2] drm/amdgpu: Program xcp_ctl registers as needed
Thread-Index: AQHZusy37JFBlTtlD0K5O2Uo/cXBUa/CJCVw
Date: Thu, 20 Jul 2023 05:42:12 +0000
Message-ID: <BYAPR12MB4614FD06D0F27AC49272C756973EA@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230720053955.3059635-1-lijo.lazar@amd.com>
 <20230720053955.3059635-2-lijo.lazar@amd.com>
In-Reply-To: <20230720053955.3059635-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57b12154-81aa-42be-8225-1fb10a0b4b57;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-20T05:41:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|IA1PR12MB6137:EE_
x-ms-office365-filtering-correlation-id: 4c3903b0-ecd6-4289-9c4e-08db88e41117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k38NtQS6BDZpcU2x2PDnLg3lCe50nba8uJ4aRn0FHmIc31UtPKRUimnpd4Y3CWpBRoaxSdfT96tGr6ZxEHQmlC7FbWik5n+ll+WUa/M5Q69vPCg5m7DvFwDMXdc/znv8NAMFEChoJPs6/Z+e9+CE06cTMH8KjGB5buhSevcxOw7cjySXIeaqc/XCtejGMWLyUH1cNcdeFK+x7WvwrjOCXDx0+2/ghMN6LAWM9HvtJkHHfFvgFLEBUeJPvMaWx3S6cICBE+0JCLl6XubjqqxD8kx/Z/0ZcUGGBGkeOzzPDeYAbB1EMT3WBS0r6dtkwtQKdGXaSQs54Y0YnVh6mtpxCD8B6uSQ91UqeZnNuLlOC+pQhtkiM+RLT/eBZH0qGs4PcoO0EWVA7dmYhr50DJlgRClP2vCJ7uev6ehw1KrPHppGctx0J65UrrHWJlv/z6Kwi7xnMaWs39+iKEI60rDZB2auRm8yELFH1piRUjjaqAMJxx45yisLfgH+AfY7L9xY6stJmqzTEoFAT29P6sSzy4kR4vpGfHohdXrmbvsMZT+02xK6jqS4VUui0+A5GSzQpkHqbrGk6YNYQo9gPdy27jkt0G8ZtyWzm5Pl3MYcEhQZsUBqcW8lq4aqD7ncVDte
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(7696005)(6506007)(53546011)(9686003)(26005)(33656002)(83380400001)(122000001)(38070700005)(86362001)(38100700002)(186003)(8936002)(8676002)(2906002)(41300700001)(478600001)(4326008)(66556008)(76116006)(5660300002)(64756008)(316002)(66476007)(66446008)(66946007)(110136005)(55016003)(52536014)(54906003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hxATyVXpZtdKmPkYN538UnD1GlEp1KRcCcz2pZRy0gQy+r1x5ZPwT5u+yuud?=
 =?us-ascii?Q?WhYNkCjQP5Tf4lUCBU19XfefL8gLBuoS4UvCXe7Ry1kdow1OM9U5lt/DYTda?=
 =?us-ascii?Q?mWiIoQOI4aKmT+gxNK5XeoMOscoadGYBWg9qGL9I13xWbNS5sV3806UUkH0n?=
 =?us-ascii?Q?U8oPvu8nyrrieQojNrHotJbDGnz8ezE9V4sRNfD9U6UU1vfttk0D1sR37hSC?=
 =?us-ascii?Q?XMu9EKxOXvgQC9ajymCpXlR0uqdpqC2KsCR/ZV2X3PnNteGxT0Gfc4/brv0+?=
 =?us-ascii?Q?3QOfozOS4ZUENAjcjeG/gQ4PIbDy9FplbWwMzcLDL0vXfvvhPIuoY7yaQFCe?=
 =?us-ascii?Q?uccSb52QevAKOddvyh+PZ7bCgqi4uRkKYjIAOqNMrqAMR12PMuJIuVz9ErK7?=
 =?us-ascii?Q?xM8dVCHmnUb/I6fqB0zI3wafwXw8oTv37DLzvBBmkJCn3vWV1RNwY4ovQMNR?=
 =?us-ascii?Q?fWSl/QGHSr+LU2OvZ3U5IUmGptm04L9Zl2D6VeNlVOB8+0pNcZE1YNMrWhgI?=
 =?us-ascii?Q?hWhoD1JbL4gftue4c5m02s99WzYvqKbGyY7JboMRBvYaTmIcNU6BSc309c8D?=
 =?us-ascii?Q?Q0Eob7XuCQCet5jtE1NR9APHjAdEl7mNxzMEW1e2Pp/3NFVZxtMBu5Na7A3i?=
 =?us-ascii?Q?MhWqHwX3WXxP7TLO4yG5Pg3cUf8d3FXxy+GeQVpQFOQUC+3Zw/ikoc5Ezkcs?=
 =?us-ascii?Q?on45qMLmU8zY16dmRgC7mCGQZP+SlSvk92k+MfJplhoAmZanWE78sB55y+ct?=
 =?us-ascii?Q?WTfFJHel3RG7dECSTtmVJ7xMt7W2YAaG5U/SMhJ+tyHQeAkJMlgmV0QeNH0Z?=
 =?us-ascii?Q?rAbej0Q57mGhMMjeIzSWAosPgjo89RHx7y5FV5UzM3/90wjILf+Sd8oHalG+?=
 =?us-ascii?Q?NZn8NTBwoxQqH0rMvxVAXPoOwCH3ZizbmjFLK9ASjzjMs9jwTBbUoTj8SdDc?=
 =?us-ascii?Q?QU6Cd5QpxFzIIHc8Bhi+g94UAlE7fMkALixoYPH40W10f0yEH9CtFgYLJ36Q?=
 =?us-ascii?Q?MJ+OKN0Jq6YSRddfnEe/5E3Ee3RgweNQXQ262yh1W08w06IEE++Sn7hT6nbu?=
 =?us-ascii?Q?K57yiSOpBVGoONbQ7u4X43g8tEXDKXzy/KY6aLF9xJcoGS9AvO3Qt1Zqg4JW?=
 =?us-ascii?Q?Tf3UREcfRCFbceecEjHZQdI6K7lRVDpsHvEVhC9DuOyRcvgIXPK9yGoj1iic?=
 =?us-ascii?Q?Bmn5LNROunmn4qt2lUd8C3uoBTSf9EwudmMTXGUH+wrwYaE1ZQNaOy1h0E4x?=
 =?us-ascii?Q?y1WuROUQPJokmmc05p5SoM2QFXXmAAYeC0gE9WwKuZGnUvy+LjEtClO88GiG?=
 =?us-ascii?Q?JJiiEktYrNON443mWqE1hmNQKabJqcZFxiXRkHwR6kIxMA0y2J7y7pWoJDeN?=
 =?us-ascii?Q?9Hmew+Ob+gaRJrFhQrVQR+YdIuLx6zsTM3Y6vmHUonilCuJLlgn+5NPaWs6J?=
 =?us-ascii?Q?lhduzoXcsToJduHogk4sx0QcjOf3GEiXfpI7NivD5BpVwgOjyETe6T2nVsuM?=
 =?us-ascii?Q?/AHMq1qNJ/DoIzTPS5JoQxuB17MAe+sVD2rGOJvXylPzLwKiS6MMiHurN1Bc?=
 =?us-ascii?Q?ecCitv5u1iH6PnX+QVo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3903b0-ecd6-4289-9c4e-08db88e41117
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 05:42:12.3493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7UHpcTdaC/MQqzLmUViJMS12xhUuuaDXKR9SVTYZm+HTLfcmOo/RqMUXJk2Ixau
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please ignore this series. I will send a fresh one.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, July 20, 2023 11:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Morris <Shiwu.Zh=
ang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Program xcp_ctl registers as needed

XCP_CTL register is expected to be programmed by firmware. Under certain co=
nditions FW may not have programmed it correctly. As a workaround, program =
only when FW has not programmed the right values.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 28 ++++++++++---------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c0855c3769d4..084ba50924e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1037,26 +1037,20 @@ static void gfx_v9_4_3_xcc_disable_gpa_mode(struct =
amdgpu_device *adev, int xcc_  static void gfx_v9_4_3_xcc_program_xcc_id(st=
ruct amdgpu_device *adev,
                                          int xcc_id)
 {
-       uint32_t tmp =3D 0;
-       int num_xcc;
+       uint32_t expval, regval;
+       int num_xcc, i;

        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
-       switch (num_xcc) {
-       /* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
-       case 1:
-               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, 0=
x8);
-               break;
-       case 2:
-       case 4:
-       case 6:
-       case 8:
-               tmp =3D (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_S=
HIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
-               tmp =3D tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT=
(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
-               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, t=
mp);
+       for (i =3D 0; i < num_xcc; i++) {
+               expval =3D REG_SET_FIELD(expval, CP_HYP_XCP_CTL, NUM_XCC_IN=
_XCP,
+                                      adev->gfx.num_xcc_per_xcp);
+               expval =3D REG_SET_FIELD(expval, CP_HYP_XCP_CTL, VIRTUAL_XC=
C_ID,
+                                      i % adev->gfx.num_xcc_per_xcp);

-               break;
-       default:
-               break;
+               regval =3D RREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_=
CTL);
+               if (regval !=3D expval)
+                       WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL=
,
+                                    expval);
        }
 }

--
2.25.1

