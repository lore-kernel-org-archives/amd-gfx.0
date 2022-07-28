Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B43C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 02:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A4010E1AD;
	Thu, 28 Jul 2022 02:09:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5CF10E1AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 02:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA1F1KReu/mXq9Fc/OOZsK0Op3k0YN4nldkeiaqyV+83oY1au1VIegNA1k+ui13manDkI5OQ5ZNEilgmE22YeuVpbh4ITmUMYqPNS+u1QMQ2L/1yijwzRoABeKwfQ77+1TYO5GMnqsDlvJ68VPId4oq+kyvOvCM9aLu/AmfTvz4RmStMqKUH9jcl4EQ1tj14OGEhWJEuJoKc48fGjwKw20JZKgvn3UMA/CUu6SGuDYlECakPZDNsfv5uqpOrBCCQ9iUEl5c/Cq6pAWGaVk/cJOFENw5M82uNKCEfZErraippE2dVbbrZa+0EeoaMjEMPdufBdQGQMbEOm1ofkjKnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya8LIbbuYajEf8ZhjqGZpt4JiIRL+m3nNYI6cS2knM8=;
 b=fKT4WqyKcqDAVA1Efdimmj7r3l0gcr5ryRAhfhxBZL42kr23d4Y8Ywl705re3Zo0dFb7afUrWKmsnzsWTCl+oYTJfJN/6XS9Ir72AnhxtrJCfZ5IOqj7el4o7X2OW+Bq+2nv2kUQXCnA/HXr0Cbis6kFU3pzOU+jRkpOfyNM9foGC8/ay+j50imkTsx2qSerJuCDrywzGlPclQd900rsjmV0iswco0uJHH2aqRUeZVcExQLInfxf4Wr9Nyv6yrzt4ivW2Z1nvwZZiCOS6rl5jG8+HdSB/qE/FLj0F/b5iYdPDmHJ6UfruZFm6mKkiN6iHQrrhIZYV3dwHSBF0iTkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya8LIbbuYajEf8ZhjqGZpt4JiIRL+m3nNYI6cS2knM8=;
 b=ZSAsTMLziSLxQlFSQ8aChiFGfCvqJ9QXzDLs/Rq7fvq/Vib7oij7vnIORuXQmm+wsgHpr8y+gYl2OyBthorngr+2eBNtapbmHTGSx5XJHPlypYR3AjkU150f+ObBE1s/8I2/oxzQhFOMIR6w4YBjEX+qY3Fj9jCtbCkjBvZjNwQ=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 02:08:43 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1%4]) with mapi id 15.20.5417.016; Thu, 28 Jul 2022
 02:08:43 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: enable VCN cg and JPEG cg/pg i
Thread-Topic: [PATCH 5/5] drm/amdgpu: enable VCN cg and JPEG cg/pg i
Thread-Index: AQHYnSc8iq1M61y38EOVbq5fSPRZO62TE3IA
Date: Thu, 28 Jul 2022 02:08:43 +0000
Message-ID: <CY5PR12MB63692F5EC0668B1B6A5CDA61C1969@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220721172712.309984-1-sonny.jiang@amd.com>
 <20220721172712.309984-5-sonny.jiang@amd.com>
In-Reply-To: <20220721172712.309984-5-sonny.jiang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7b71dba-3ab1-4cb0-71b1-08da703e18d4
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQisb51+bsmmMryQfg2GF5OKxZRHVDsA2jwta0XHlSTXQOClki2Ar2+XUi45NMBCgbR6LwufxTJbRWBh7Su0mwQlFailB7LHvad6fyKOnaCV+A0ejF9xAIryiK6zoIRlBR0OYOqVJNf0AufkdgBgINS/WNuwQRT9OSfh6M256Z2qNoYNmWei7Qw80y/OgsqgY7ZP4Oi/C7j50wbHkgiaCsyq2phXLgWDoiAF7I3eMBGqEm7sT/eEcN5VeKXOKY2rE4f4ZHpQVttMyKFpHcAdxjmF03fHHSmFGVXyYzhAplpSu92AK7NDD0l1vUqqW87cwWD+SW38dmNW22+DptgAytuGTFPKQupfo9Ql8pMRj1KoSq2Viuau+zWeLZ5T60OLawKMP3et7YmOWRs9TLaY+clKW6XbBMhaSlIF6l+GfmSJ02R+/I+8oH4hQP4/oWCLQaJXUPduVuKUFnoyvSXK2J0cfQxucwaCrd/65b8wYUqFjnXs2SgaKKJke7ZwOtWTGmZK2mmLA01b/8UOvEY274muGMgEi5CoHI0vkw8tQl4GK8CKZp0pzUoR/1Ns6C1o4bMbSKEciURrsa3HwNUFkdQjyPBcSTcFhsdPyYWuo5FGHRBS49YnsaNg5UxHzG6OVsD4jCzn56yoH2oaPSs4XYoFAgjAEobpc2sGbiPDgPkZm8IXbPRfUNkuSaWZA55cK7OwuwOnGJZSPc2WN75QF4HRXFeVPw4LmpUzLKp+jup27nkbdX9eFX/bCyq8kCzow2ZSvoTfg2d458OsTJ87kmAHy4Z71T1XDjzrJkGUcvpXDNvZI7Gj8q5fice0DDHK9+oZtBGO/zK2S4IcAxrsMg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(53546011)(41300700001)(2906002)(316002)(52536014)(6506007)(9686003)(33656002)(26005)(54906003)(38070700005)(86362001)(55016003)(83380400001)(66556008)(64756008)(7696005)(186003)(478600001)(4326008)(66446008)(8676002)(8936002)(38100700002)(66476007)(76116006)(71200400001)(5660300002)(66946007)(110136005)(122000001)(129723003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mxpy6O5Z7NpjsAUlBEmmrRFVAPnob7iPugvZ08KuDUdieNHbtfX4eEalk1Yf?=
 =?us-ascii?Q?CK1xgGJXSDnMDIfn3RiYDjXHxqJ5WDBSGJKCC38p9zkp2y2R1wM4zHz8Rre+?=
 =?us-ascii?Q?QMUQ0M+uWXCZD09RY47E8Ts+7RltECC4BWHIVmOJGBl6ufoYZfn/UKrZB2w7?=
 =?us-ascii?Q?3wBi8c3GEs5T6Z7uvt5q/D7jf7rgFXada+NV9JH7YG0tjXdnFG0KTCv/Kq1x?=
 =?us-ascii?Q?kOJzdjy0oh9ZIyXr+QKC5Lu5AVUJJ0YFudvKWlUPgpUEAjkwB1GO4JNtzxxn?=
 =?us-ascii?Q?g+NShv0xzG3Rr/wxuij5cSQ9F23029SIkaLjW7uNtAPtIPWsPMCe+CYSrosU?=
 =?us-ascii?Q?sy2gs1JUy05LDGrOcWObYWoLLJfJxZZTUOpgXefuDfqm41lieI1N9zJWA0wX?=
 =?us-ascii?Q?Uww8yyHEV9BAK13oclMEpP/uMwlGy5yaUgrY4hPsxvAO0WF6wt7eocD8CzDe?=
 =?us-ascii?Q?LQsSlILgouIk5VizySiONFdYRUTzMu7NvCbAoVA1aD1QFaRU3MrLUHlTRBRf?=
 =?us-ascii?Q?DQWUEC+AO//Tika/o8732XP0Q9RRU63oPTPH9nppyswPnprYZiAW7OfbAD4o?=
 =?us-ascii?Q?ihCXeUIDtV5TWKDBtuLt+LK5c3PPpIGKs143ZCng6YKk6C9ClzeyiIvbqNUC?=
 =?us-ascii?Q?m0OuFwDz0ysKKxf0OHvX6hHYOGJwlh+hrbkCc3ilQxdtC8ft6qFzjSWo2p6D?=
 =?us-ascii?Q?wK58/sh2oc/ko0H/Vj4UspQNzNwya3zIjRdpUx2DoYnrUgMVyiVmegoseJce?=
 =?us-ascii?Q?h+H20gH0ofEO5+zwzjaltMfXjhXE/no9uW85EMG46RCkTVkd37f4jdk1Qgas?=
 =?us-ascii?Q?y9mubTbDCMlLATBeu7Y/qJzDel1HM9vpyoajAseJb0y4yvIs8mS0JYZb9xyu?=
 =?us-ascii?Q?k63E3VtCNE7cHeZY8/ZjE+QhnCXvIk1zES1TGaw9qX/tckuf6ALIX3Zr+B36?=
 =?us-ascii?Q?PZlJmqPekJVzyda2+nTu8tLXeCq4aM6cFioSxuqO/idhzmDIOJ3C3pA5869t?=
 =?us-ascii?Q?eXQ5yhD3fhZBdd7D3xUkr4QD5eFime2oFku0XHaSi7UhQ5rut0ysJpdwExvj?=
 =?us-ascii?Q?MhGwI5Wo+cdHxP5Qp6p0ttWZAJ/5Ar0BWaOJY7R9L4PaAWQdihmp6+03bobb?=
 =?us-ascii?Q?X0QUvhs1umYGYt1xthR4F308RQ7R+pB0aLAgvvMOEEoSbZ2lSbczHorqIA4A?=
 =?us-ascii?Q?TFTDV5bM2+VYpPGQoe00uoixr+3ycNRi3KSVpj3zq84NB/5/m7KfJjwKfzCF?=
 =?us-ascii?Q?s75BZ8uvD9zS3A6YziIBWvEJYxw3d9eBHcOeYa8DmpRDvATMXtf+VuUibltc?=
 =?us-ascii?Q?JsO1SwtfNaXsHVTw8cln49JGYoMCAlLkFOPdk1xr3HCUtDv8wNyJ7COfdcfq?=
 =?us-ascii?Q?E4DZNzzlSZotFOKERlQ6hKO6C2gOSU2y/PbsZwVzNQQpwzlmb8i12sp/XmOp?=
 =?us-ascii?Q?Pe6EDphqDCswNq5iXnQ41dkSAlOzCunSM93wPxoaw2lBQJaEalYjYSQFTZzj?=
 =?us-ascii?Q?94XyNTy7aAdOMd0rAJIWIlTYDG4RUmq7bVrsbynQ9tMTR3c3TDX/EKfI6Mzf?=
 =?us-ascii?Q?6cha0wi4fVHJiQpnytU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b71dba-3ab1-4cb0-71b1-08da703e18d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 02:08:43.2893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdxMMx6cQifhvODA+gxeBQM60jguF9MABKfr6NNyLdY7lcuusnH6cJ2s4rLofm3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
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
Cc: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Zhu, James" <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping

Best Regards,
Yifan

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sonny Ji=
ang
Sent: Friday, July 22, 2022 1:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: enable VCN cg and JPEG cg/pg i

Not enable VCN pg because encode issue

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 68e78983f956..52816de5e17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -585,8 +585,11 @@ static int soc21_common_early_init(void *handle)
 		adev->external_rev_id =3D adev->rev_id + 0x10;
 		break;
 	case IP_VERSION(11, 0, 1):
-		adev->cg_flags =3D 0;
-		adev->pg_flags =3D 0;
+		adev->cg_flags =3D
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
+		adev->pg_flags =3D
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id =3D adev->rev_id + 0x1;
 		break;
 	default:
--=20
2.36.1

