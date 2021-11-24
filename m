Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2201C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 03:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097D56E19B;
	Wed, 24 Nov 2021 03:10:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260CD6E19C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 03:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnTfGQLTqE7ZdLqcKyRhWeZHYDXR4T+pQigCd3eZHlMBS88aTFJx6YkMtzAhozQgfn+y2v4lB4TNr3B6z4YoudSKZa4FWXv/747NM6yhCgYTFubmhRjbCFzYlY1YKrQa2JLBYMEj1PyFxNsv2edfjI6Wf/jO+8yDjjLlgEz9XgP6+fok5CBltq5z9HyucSZzPVBNz97pIkJA3G7CldxWbj6xFxIxWcEG8W/8ESsHHJVD4kbIRXPZMPZaOt9jrjMctrzV9KgEv20fit8/25/tzRDxfkMfkkOyCoWKLbvhTlsRun2/iCGRaH3wBWnyVb+HTJeyNiFuJuBrJlAVT+23zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI4Ahats98PA4+zqc9ccJ7s2qBPggDKoUej0I3ZIW74=;
 b=FGOC4TLdwZ2GWcYh+UIuF+vFY4fXn/W/mf3MX6sEyD3khsuEwXPUfdT1um0h6uGzPmDmyB5M3JNCAqm3SDPTZEAwma++B8p3PnPuHk7mrjhUeBauZX2DkVh8cgxIROk+6c3kcn01wR+YXoah0L04LiLi1ZMcf56eY25Iz7sM2uBpJMI8i3sj+stBg5xBafWVZzuy2qmaKhcA9OeI8m4BpcOrwRDOFCk0NWcEzUocnNIKTf9b0a8y+K8e64mSNYfkbelbVAzV32FJ10LLTGrSpoFIuP0ukkPrcIfyc3vg3zO7eVx7iLYk8UnEAREwdCSBWSy6qCDgvrjfoT6ATEsFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI4Ahats98PA4+zqc9ccJ7s2qBPggDKoUej0I3ZIW74=;
 b=12T7UWHp/l8NISPdB/3AgYsvITx26WUKxCfoU8wS86OPqlJV3LygWDvYHepAFDmgl5jLj7qfOBQSFVs/Kx90WHAYxbO7s6g54W/tVBocOA9KWenuDalT+39lerHWOX883r3zpy6FjAD2MfDgvp/0rnfN2Nym+AoGQv1FGS4hmRk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.25; Wed, 24 Nov 2021 03:10:16 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.019; Wed, 24 Nov 2021
 03:10:16 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Topic: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Index: AQHX4F4eIw9oo1nZWkKbhIk9W+yIG6wRNY4AgADGo4CAAARNwA==
Date: Wed, 24 Nov 2021 03:10:16 +0000
Message-ID: <DM5PR12MB24693A5217E29CF7AB11C11EF1619@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211123113438.5200-1-Jane.Jian@amd.com>
 <BL1PR12MB514481ADF439A81349D03279F7609@BL1PR12MB5144.namprd12.prod.outlook.com>
 <PH0PR12MB5481EC5D76669F66CAB44F9EFF619@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481EC5D76669F66CAB44F9EFF619@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-24T03:10:13Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-24T03:10:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e4ee55a7-537a-4536-a284-4f2ce15b9604
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0dc5e86-8086-4a0d-fcac-08d9aef7f0b2
x-ms-traffictypediagnostic: DM5PR12MB1163:
x-microsoft-antispam-prvs: <DM5PR12MB1163E7871CFE75F09B4BE93DF1619@DM5PR12MB1163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ErITFXSjw6uXXVKce2V46bSllRccV9m0sW2CsmwX5jOxvnnRyOGSSdlw5a5a2nKBQm6pR5uYtzxXNFExeCt9Y9TVueZAOeVDNUIDMl4t14l4IDeMAY0v5t/Ibma0h7DiAPG9jRWQdOAkRAMPw6gz1Z2GLowZ5fqHvpRGv6qPHt8PEg4zMQyoljz/c4RIA529K1j7zgnOQ+rITBPEI1z5pxD7+ZWtwMGn8i07KJPO/yuTXBU5KtPpSmlfYyFlsRQPEPMFkabq06zLPwXTkhlntTDgrOqxB4XUlccx279v2KyBgqQKaXEvQ+50e/qfIdchKxgtcW1poDVAZ5wU0L819QsfXnM2+jrX1Zo4sMSzCUHiy3Yiit//svRsCgKCFLleWtkB086IXN25SRgiaubf7G5r4UtQ8ZVXUn4rqy9VTbAGQogwTSNlGq0bJ4ed5fHqUG4FNJARNVojK3+9ny5craAzsgrPiUtcVb9KiQqvCcXNfQkzg3pikLKqYpJkaJy+1w8ALuGqqBxQXFG5ZUgADiVZJSqQhvTeNWKhGNd3QUmAl6tKkzITUqmX1hUGNVpcjExU5iKm0t4Fctukfqx5S4sEElzqZavsKyh4EXMNshu5F1OiqhjWQEWU7AfdHdBsa3sDlcTSsObdbU4bgavfnH1CyQe6NHeOIvBM/fnwB/WyOGOq/4Y8S7Q1hsbqscS7t6EzniWVj8iIOczF1IXcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(2906002)(66556008)(6506007)(71200400001)(38100700002)(83380400001)(316002)(5660300002)(508600001)(52536014)(66476007)(66946007)(8676002)(86362001)(7696005)(76116006)(53546011)(6636002)(33656002)(66446008)(26005)(55016003)(186003)(9686003)(64756008)(8936002)(38070700005)(110136005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6p9HfyerqlCMTZgUuf8PMIYENO1AUgfmgEWG9JS6RqQzjSGAF0NPwzVjnr9I?=
 =?us-ascii?Q?BURCPsmvBguQH+hPk5WvgKX4sIsZAhbNOnbRBKgmJiHM8apaJUvW4lT+Xb5n?=
 =?us-ascii?Q?eMC7pTgx9oQYK3Vr2ULoDDPeDygqYkAnjPOECWVlqfOh1WK9y3qyJklSg7jt?=
 =?us-ascii?Q?D6nmlTdQyA4gJbdojpHauaakkVMrnIYuCwnksKbU0AkUvqr3WsZqWW4EtEEX?=
 =?us-ascii?Q?ZbzYDROu/NMuMTNFtrSFvOPH4wXTpVooe6OQBCuZc7WHVQTBKEMu6twvU3ju?=
 =?us-ascii?Q?WBKfz2lheyHyLf/ZNJyCQvbOHQ5+T96fK5m/q8ShbFQYwsq/yKzi2PwNQdP0?=
 =?us-ascii?Q?aFWAK8ujSydXaJKtT0ipQ3SkIk/rrQv70yEIDJx4xXSBORwMr1VWhO8B1s9l?=
 =?us-ascii?Q?0LZXZDCXuwZ3lf6Vk0mV1b8mtthDR+wi8PmGw34wazQ/wKMjL3SbgvrL7mo8?=
 =?us-ascii?Q?7TBFigZhzEKyhH+QDR1F7E2v5mxFTwohK9swEenGqUAcMUm/AOZF5ALvq2vN?=
 =?us-ascii?Q?x5Ut9P2qSq4WoLcfSTqFQvSx2KG6kf5J36nEGBFNPnpaYGUL6S2n13R+YJB3?=
 =?us-ascii?Q?VSyeeVAFklcmVk+FgfqVFfHZ7j+tYtIVCWvTHkiv1N0uKRXasN+1AYngDmxe?=
 =?us-ascii?Q?I4LDVuSQKM+FGOifvZ+TYzTO9aCSCNO8APAQYP2i3wRNTfa4DG3BA16MKW2Q?=
 =?us-ascii?Q?BeNN7s4GSCaT7tN9lwQ+vcRDRc7P++DIJOg1KlG/5RXCvhy9PZpnZ4SyaXSF?=
 =?us-ascii?Q?Nqx/h7zw+EB58926NWUqSxs7W66NrvWxsufO4+jXaTUZDqGaYjwUVArYdX4F?=
 =?us-ascii?Q?ZfraID9cuab4mYpn/7mfxPi4LMdx/OhIoaXuT00JzVhMHibbcF+sZgySzrby?=
 =?us-ascii?Q?dsuYP+dV4HZuODaCVhh3YvQv7gxAI1reIzhSQjebAdt4j8+eUoDPnKFznAky?=
 =?us-ascii?Q?MPI9qMIQdfsZH1ZpRAnHFSFiRgGOaOVN+PFRbW9DIyGzielHAKtFB+OBNfVm?=
 =?us-ascii?Q?Yn4nLFXOUrMiUEzCDeD8DsZbBQAi6FTIyX8plJNzKrDpG0vDEMQeCdEon3Tk?=
 =?us-ascii?Q?Ef+0ev5XMFWIWntIk7wH6D1jq22QM7goRlkW2gMYAL+zPztveXTsJdijaiec?=
 =?us-ascii?Q?u8vmIuVsdioZTTyVtnNHZ7EE1q3VIWeQ3uc4b26bVtIfXSRnaDPwhYoaCgHy?=
 =?us-ascii?Q?LfGsPZTzuvc0b3RpazANZftjjXR2D+p7Id3XmCK9Vr8p07ybLmVLozlkJNPG?=
 =?us-ascii?Q?kmL7jGXIcmSFJ8dCgC9VZN8XFqQORP53r6CkBhgFPhPsSV7Xdn93K+jtH2V4?=
 =?us-ascii?Q?lOWABH0smYFi+qUxD8e28Sm76kM19+EuFtrj1AB100msoC107VK9l9Zrm5Mt?=
 =?us-ascii?Q?MNCvM3e3IWUNTSnfQRbMp8EGwlnpCHiaUg0FOB88Sg71IjRD9v9BR4qGvHvb?=
 =?us-ascii?Q?5DgITpsbIjNowXkoj5BxHrHCmMkh0OCJpqlgxsg7u0k/mKYd7RqG6TCmRPkG?=
 =?us-ascii?Q?SriGYs3zVeRu0E/waE8Auj8XqqxZODBj6glHlc8JP2lb/rKwMDXw/84detx7?=
 =?us-ascii?Q?FPDtJEmOBmUnmj3ZHk/n8+J0G8U/u+JIyrSg43omDQ3yl0PLVD/UJF2WxYYS?=
 =?us-ascii?Q?c8QInFKD/lJNyNX2ql/TkM0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB24693A5217E29CF7AB11C11EF1619DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dc5e86-8086-4a0d-fcac-08d9aef7f0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 03:10:16.7293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUsLupe+KsMPx117vYiT3ARdxsZ1ud0SpXu3WDIviZszTWa9Wf/yL4qBxikQIxsRVDCi63/beJ4J74GJFoz9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB24693A5217E29CF7AB11C11EF1619DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Jane/Alex,

Adding a check of new IP in this case looks good to me.

Regards,
Guchun

From: Jian, Jane <Jane.Jian@amd.com>
Sent: Wednesday, November 24, 2021 10:54 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to i=
p init for SIENNA_CICHLID


[Public]

Hi Guchun,

Per Alex's suggestion, we would better add a check for new vcn0 IP version,=
 which is a version only owned by sriov and a way that I originally did, ho=
w do you think?

Thanks,
Jane

From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Tuesday, November 23, 2021 11:03 PM
To: Jian, Jane <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Chen, Guchun <Guchu=
n.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Chen, JingWen <JingWen.Chen2@a=
md.com<mailto:JingWen.Chen2@amd.com>>
Subject: Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to i=
p init for SIENNA_CICHLID


[Public]

Can we just add a check for the new IP version in that case?  This looks re=
ally hacky.

Alex

________________________________
From: Jane Jian <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>
Sent: Tuesday, November 23, 2021 6:34 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Chen, JingW=
en <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>
Cc: Jian, Jane <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip in=
it for SIENNA_CICHLID

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia ban=
dwidth feature),
which will be mismatched with original vcn0 revision

[HOW]
skip ip revision match case and continue use asic type to check

Signed-off-by: Jane Jian <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..0a91e53f520c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1334,7 +1334,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
                         return r;
         }

-       r =3D amdgpu_discovery_set_mm_ip_blocks(adev);
+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(a=
dev))
+               r =3D amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+       else
+               r =3D amdgpu_discovery_set_mm_ip_blocks(adev);
         if (r)
                 return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 4f7c70845785..87f56b61be53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -86,6 +86,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
                 atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);

+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(a=
dev)) {
+               fw_name =3D FIRMWARE_SIENNA_CICHLID;
+               goto next;
+       }
         switch (adev->ip_versions[UVD_HWIP][0]) {
         case IP_VERSION(1, 0, 0):
         case IP_VERSION(1, 0, 1):
@@ -168,6 +172,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
                 return -EINVAL;
         }

+next:
+
         r =3D request_firmware(&adev->vcn.fw, fw_name, adev->dev);
         if (r) {
                 dev_err(adev->dev, "amdgpu_vcn: Can't load firmware \"%s\"=
\n",
--
2.17.1

--_000_DM5PR12MB24693A5217E29CF7AB11C11EF1619DM5PR12MB2469namp_
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
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Jane/Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Adding a check of new IP in this case looks good to =
me.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Jian, Jane &lt;Jane.Jian@amd.com&gt; <b=
r>
<b>Sent:</b> Wednesday, November 24, 2021 10:54 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;=
<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check ca=
se to ip init for SIENNA_CICHLID<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Guch=
un,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Per Ale=
x&#8217;s suggestion, we would better add a check for new vcn0 IP version, =
which is a version only owned by sriov and a way that I originally did, how=
 do you think?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Jane <o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#1F3864"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, November 23, 2021 11:03 PM<br>
<b>To:</b> Jian, Jane &lt;<a href=3D"mailto:Jane.Jian@amd.com">Jane.Jian@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Che=
n@amd.com</a>&gt;; Chen, JingWen &lt;<a href=3D"mailto:JingWen.Chen2@amd.co=
m">JingWen.Chen2@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check ca=
se to ip init for SIENNA_CICHLID<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Can we =
just add a check for the new IP version in that case?&nbsp; This looks real=
ly hacky.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Jane Jian &lt;</span><a href=3D"mailto:Jane.Jian@am=
d.com">Jane.Jian@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Tuesday, November 23, 2021 6:34 AM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D=
"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><sp=
an style=3D"color:black">&gt;; Deucher, Alexander
 &lt;</span><a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@=
amd.com</a><span style=3D"color:black">&gt;; Chen, Guchun &lt;</span><a hre=
f=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a><span style=3D"colo=
r:black">&gt;; Chen, JingWen &lt;</span><a href=3D"mailto:JingWen.Chen2@amd=
.com">JingWen.Chen2@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Cc:</b> Jian, Jane &lt;</span><a href=3D"mailto:Jane.Jian@amd.com">Jane.=
Jian@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case t=
o ip init for SIENNA_CICHLID</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[WHY]<br>
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia ban=
dwidth feature),<br>
which will be mismatched with original vcn0 revision<br>
<br>
[HOW]<br>
skip ip revision match case and continue use asic type to check<br>
<br>
Signed-off-by: Jane Jian &lt;<a href=3D"mailto:Jane.Jian@amd.com">Jane.Jian=
@amd.com</a>&gt;<br>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 6 ++++++<br>
&nbsp;2 files changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 4e3669407518..0a91e53f520c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -1334,7 +1334,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_mm_ip_bloc=
ks(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID &amp;&amp; amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_device_ip_block_add(adev, &amp;vcn_v3_0_ip_block);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_discovery_set_mm_ip_blocks(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 4f7c70845785..87f56b61be53 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -86,6 +86,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;vcn.num_vcn_inst; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;adev-&gt;vcn.inst[i].dpg_enc_submissi=
on_cnt, 0);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID &amp;&amp; amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_name =3D FIRMWARE_SIENNA_CICHLID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto next;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[UVD_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<=
br>
@@ -168,6 +172,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+next:<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D request_firmware(&am=
p;adev-&gt;vcn.fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_vcn: Can't load fi=
rmware \&quot;%s\&quot;\n&quot;,<br>
-- <br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB24693A5217E29CF7AB11C11EF1619DM5PR12MB2469namp_--
