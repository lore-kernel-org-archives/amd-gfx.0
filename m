Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16F0CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 05:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0EE10E40E;
	Thu, 12 Oct 2023 05:54:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB94F10E40E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 05:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAKzmPX2vNTaGhR7QDP7liFdliUvbfkiNzTtNz0cjwCA9NalQhUKq8mRCa/YfyzSKeQsZtbfoHBbmOenyeV1JpQ3o/YTmmL1We2MS2HN612etXWiH2padq8E5yFFAm879syiJ6UiqPe9obO10t9lQWp5iDIMTMLMKss1HnALeal7lxD86NqPflpgdWnuXvGvwuBCF+K5yoBMQ9piMKd4GMEv59mcQ2Pom0o0EOS0DL0LA07GvHLjAJLNUW1fTWdcMebHA+WL+W20Wh5kUl49s9FR5yOal/+zkpHJ8puaUgeZyNHuj1hvs3w/bACPeGUu2QTcZHCNaIhDMzShtKYuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQgAtWbn5dWhEZfWv8saUC6eYvYKWHzxxZAi0QcTZF4=;
 b=hC6XuI9G+jWIfcsjd+xmwQzWmcXl8kPWrHMgnkZAui8w4HE9rQnO7s+ypXnAWdQfxTmm6OKz3MWG2ythN0LI1MjwvBW5N3DuCXBZbBTa0fLWTQz5b9z/ARaLRDm2G+A96ZB/VHS+r5RXOLbi3YFicG2Rgc1GVg858+cLVVF5LX4Cs5vaS5pqY+vC2bPtdPdsVoSPbaWpyniqz5turYh5eQfUcXBtLo7zYI/7yKYVL2BcUPDA2jYjjyKAgflhu16SGqR6Uul+orKoZ44nupb06xbvf1giEyiNa51r9c66tg9q8eYDeha4PaVij626b/neB3ZpsMOW78YNzbL7gCuowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQgAtWbn5dWhEZfWv8saUC6eYvYKWHzxxZAi0QcTZF4=;
 b=EpV13rNOS3ECW+mscflSp8vtAVW6h9LqRCK837m6moamCPZJb1Vv99oPOufvspkFkf9ff8RUlTCcWwQQKBxQQZanq+9nKK2HTh9I8efrIHUxD+nHHGi58XquTxImAZHOTGOloe0bXhpB/hwxk9bqA0FDK6cFd6cpTp0w2aZbC2I=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 05:54:03 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 05:54:03 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Restrict PSP OS version read to PF
Thread-Topic: [PATCH] drm/amdgpu: Restrict PSP OS version read to PF
Thread-Index: AQHZ/NBAZeKHAk496Um7yKwdbVPxJ7BFpx1Q
Date: Thu, 12 Oct 2023 05:54:02 +0000
Message-ID: <BYAPR12MB46140A607FFE8F28FEA1429697D3A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20231012055124.112725-1-lijo.lazar@amd.com>
In-Reply-To: <20231012055124.112725-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f925a360-3d7c-45a9-a3fb-76009b7d156f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T05:53:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|PH0PR12MB8051:EE_
x-ms-office365-filtering-correlation-id: 0863966c-a21c-4b24-656d-08dbcae7a31c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MtjKK2YP/xtSsTLJgMeZ0ho/FilN1cqdHlfqPFYlGWETLDVZOwtbQbrkCzSGj1aS+JHpDqJRIdUfDty9JKBx3b5emmbI+Hke8OmNSaO0FdpcKVRMrmxm/KpsttrEs6BRI0e7ZrP+u6DM0SWpZCCd2hKUiBEPVa+pmz5wzIoc+ByPCju87m0Ce2oBUvt21OwqNQRNka/y85yk72Zg+8kJNYznWpgi3i6g1jGWYAK6lOSO0ZaDkEHusO2jdj8YcXQaoY2/2gOf6ntHxhXQOJe96O0c0dly9STiNXnFpsVu1wVDg6i1HrO739LORoqBISHxvlah5MKn80e1aCiXttZHykzku3EnkHksAP3LXvpwOiVnyrutb9NvxHvkXo0GABrJpICWA3g4mcAbu4JcPexSYWeiMDNePc98xlzeJj3aasTwMXnPpFIieFd2RV/L/WmVh5eDqaeGP6OplQPGIGZHtqwyk/H80gqpRR6kVd9MMStEFyGPIdv/mZGDQZr1m8DHUsow+X1orGtyte/UAXpes4IU4ftFgFzaJoG4f81Wm/Wnq91DXcH91s+ODP/COn1W3WkM0ZK4I+ECOZ7B33rK79fakd48CUbklwX+NfvuE10JH1+ybjoy2rRkXiexmVvy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(55016003)(9686003)(53546011)(7696005)(478600001)(6506007)(71200400001)(26005)(2906002)(83380400001)(41300700001)(5660300002)(110136005)(66556008)(66476007)(54906003)(64756008)(76116006)(66946007)(66446008)(4326008)(8676002)(8936002)(52536014)(316002)(38100700002)(38070700005)(122000001)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QdV3S9DmwJ/oRFRVgb2kBQeB6BXZLdvoPWMG2JMZgctyHxe9Tf+3ZRIj9IlB?=
 =?us-ascii?Q?VQwKthvIoS5fdUZdqlwG01PZyLKVFTD0/ZTGiCvwzNB+w122Ss/fd3ARQblE?=
 =?us-ascii?Q?Ejk1WL6AHpJ1dNObtuEoGt/5ItAlxpK5Ke8XiYwA+il1G9Gg4t4wIHdqayrl?=
 =?us-ascii?Q?4maaKMq/YZ8fEWyCaBd43ToZ9u0Z6xa1EUZg1FlDnZ1Edc7z8r9ZVyL6mpbn?=
 =?us-ascii?Q?UjqyGSMlKrr3jxGg8hw1GvRCd4R9tWTHBXnWehoIlEMicPrvlb446dO8XDtF?=
 =?us-ascii?Q?rWJxsOZsttFhBgm4wk1EePpgOSIUw9axBYBwp4FZk2J2FQ5vHWv6/CMGDSXp?=
 =?us-ascii?Q?0SYN5lgPbcc0j388sPXOrLzVt6TkHUWdS2p1II2V0y+Ek2ld+p2Z5AUH7sFg?=
 =?us-ascii?Q?EOuVwV/hjJvYhyEQDYTEisChpAmtov1iD/Yau5b1TWEyLAO4pWOb9qsNGUcs?=
 =?us-ascii?Q?yCDnO9PLhoFb5kS5gZMHWfBGKjVMhbFM+LrbyKOyPmWcOTVoH5mUIALQB5bU?=
 =?us-ascii?Q?rWMeq0rgDx37Kr/jVrRLNgNb8tpYTRTktVMG1UA7JGkT/7sr/otqb5Tckwmb?=
 =?us-ascii?Q?2J4kE1UAdm0VHHUvSnSNmQgkcGtu5McCkx8th7yz3OmprG1Z58vuPvNlJLSJ?=
 =?us-ascii?Q?IHdS/+TIma+mw4t/er8zUChYI05rnn7PlPo3Kd2QrYCvUmVkaSkG1GglSziD?=
 =?us-ascii?Q?0Eg9t5xPqUjE4DHct9mgFIA3TSujr5w0HKslO90gEKN/8xkEUEKhPYN5gomV?=
 =?us-ascii?Q?KRXFEZFXc9KA2uvjzZrz50mBT0Lb2vXD+tLmftCKhlAFnKDHq/XJ3f5vfVDo?=
 =?us-ascii?Q?gD83ZYUeF5PF71fTr/ZUUCx3ed/QlxAVm+bMEr0nGxUQ/SUStDXP3AH070iZ?=
 =?us-ascii?Q?PB5cclnyHlFsERvn7s6vfPTtdaZXWJJt1WIuMOC+ecMV/l7IEBpLadNVxgAE?=
 =?us-ascii?Q?ZjBTUcPx79f+Xd/RdUsT5e4KTB/o7h/JZbjjBVlMXGq2LkvXzcsR3EIID2PN?=
 =?us-ascii?Q?04znBmkACFBXNlmjSKmdLZeySIv4KxevA7arT0HJjgzHz1HHQKcMQ5QWHV0A?=
 =?us-ascii?Q?w3yVxk6uZvTuhHIvVAUWk4I+JJMdfXB9RQQoio6aeFttzZCBLKZsCuD9R4wN?=
 =?us-ascii?Q?ZA++ndO+4vo97bTSz0avuFtkYF9mo+xhLWgaFq92e2lGxS1RDpsfYJ0ncooP?=
 =?us-ascii?Q?Lh6wM0FC7aFh97os+LGEb72sAkoPFHPob5fvnYKVSxOtrn5PoOez1eL/bcPz?=
 =?us-ascii?Q?qigOxDzQeTpLpPrM7Eor/MLtv5cJR1YtPumPm7DQQdfR7X6zURxch/n6K57z?=
 =?us-ascii?Q?fwnmWfJzSsFutIh6A+1tevzJrFTtKm8O/vs6YEHPcwpPHmzJx7AXqUUb69z/?=
 =?us-ascii?Q?Ho3M4fDavUvoTKcSZCm/RdKOThl+oKXR7QyBWmpUFTwCrmg38SHEcW5Yp+q5?=
 =?us-ascii?Q?ESGOtBX6yD85x+DTBdGjJvWu7sR9TlKz3KAC86CjigU8QPHmZnRyR0Uy7Ez2?=
 =?us-ascii?Q?FRMKioOsqUXsXvKwzoSfdeC484rPrvfzoAcxS2xwyjd7lQv3YrJ0xq0ddKRn?=
 =?us-ascii?Q?sJe7K8vzZnPoXmsyFRY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0863966c-a21c-4b24-656d-08dbcae7a31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 05:54:02.5260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eTMxn1iq1w2sBoZyR2bPvpUoTaVPgqvSWbc7ek8KvvuTokawQSTeuBp/RgTArnR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please ignore this patch as tOS is not loaded on VF and hence the path is n=
ot taken.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, October 12, 2023 11:21 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Restrict PSP OS version read to PF

Only physical function can read PSP OS version register on PSP v13.x SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 1997260a8156..96ea64e1bf37 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -280,6 +280,9 @@ static inline void psp_v13_0_init_sos_version(struct ps=
p_context *psp)  {
        struct amdgpu_device *adev =3D psp->adev;

+       if (amdgpu_sriov_vf(adev))
+               return;
+
        psp->sos.fw_version =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_58);=
  }

--
2.25.1

