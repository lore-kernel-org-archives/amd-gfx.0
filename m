Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDE8C001DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 02:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB59310E0BB;
	Thu, 27 Jul 2023 02:01:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F9B10E0C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 02:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hud0TkvrvjTIt072g/Pqj2AYUAFw2KiIx2rjiLQ5gSGFmqm2ilNQ151L/Jy6o6k4rVAwykXyQZ9fsepUXGTY7IiyNJZS5L0b3FnYCu6bDeFG1/xDTCTkifT76Ak6tpzHXrmucQkh2kKmGMxZWwqyg4C1izAWmnV6GVI6/TCAnobQ6KZEGpoqwGiolQAKwlq4qEpqgMdSD2vqOBgrLRIrENamE/9P45AbJ7kjXwETr3+ZFd/Cvk13vaeUIUSoOpcJpgtsgOrK6Ex5J2qDuVG1hlNSCctO9j5afRTz1jHIcub/XfTf8yNpggKmjUWgt0+0c86I1EBjiYmSTd/g8pJmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz04C6vKvOcME0Nq9NExd7EI9Noi8R9+xSEESVt8I0Q=;
 b=OeSm+JcSG20mDgESM0QK1GYrQmIyRwKezRzhOTpDHRtyb6nTWBBJaWizEhHRyus7yDRNCQoEO/+bwHzzomVCFdUoAFvReSDYb53Rr8vCSaiWnMfcRJ3ObOVPnHqxiBNY893ZSbUkhAYn2DxOVBQYdowBUBCfdaYHP27SwlTwN6f2qTaMyVr++VTWhgmhsXRni9mIVdiNrQilytq0l1SECM3cSy+jff/gIdGjI+CgRu/KMflWYWtqoS5A2CnpmlwP/U4WiaTy4kcNjHRiZS3QJJc2uBMZdrSzsH0DNWuyx77XY+s2ZSV9Ljbc11FgGoK94txr/WlG7TyBvTGLzjtq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz04C6vKvOcME0Nq9NExd7EI9Noi8R9+xSEESVt8I0Q=;
 b=iEJKeuIowUiaHJqK6m4ZNwJLT/yxI7v4G4sGNKis3MmHxtKaSQrSeCB88soX6E8k26pYR7fHZYTfPHq2OtyBP97KufkyAdk5WXfWdKfs7lgbtO9WLEbkx5xn2HNWzpH6Ds0CKR/i+5+DT5zR/NaZHLIOHbV5QeRYcF1bnksTBhw=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 02:01:40 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e2ee:2947:91e1:82c3]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e2ee:2947:91e1:82c3%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:01:40 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping
Thread-Topic: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping
Thread-Index: AQHZv7PdrhpnFumjZ0ec0XfiDLsTza/L8rUAgADnbpA=
Date: Thu, 27 Jul 2023 02:01:40 +0000
Message-ID: <CH2PR12MB421533576E2F0265F1AD2B61FC01A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20230726112446.653625-1-Lang.Yu@amd.com>
 <BN9PR12MB525798EF052541B0EF1E518DFC00A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525798EF052541B0EF1E518DFC00A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=07298222-9798-4e79-a706-bad4ead32963;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-26T12:00:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CY8PR12MB7123:EE_
x-ms-office365-filtering-correlation-id: 910cce61-3d79-4113-10c0-08db8e456b2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yeL7t+ANLuHlqTEzgJVR+/hLI3PW8CfPo9np8N+DBJ7fvGaFW4uNEvDU2nN1Kka4+SoSbUA4eUgB8bpWh74OGHM/49nHfc9ymYRvqceQ4CW6oRrHKw8ipqFrVnm7gXIJBVvmT482s4W70WFcnqp/P57uE3KwDhYt/3HvNR0Fu2Zas9EEueR6+OZiMXuHrh0QgwUh3ccV2gCOC4aF7IKoc1ETq7YXGhaLq1Q+5BO/CwMuCuNWfoZZBs65FWyCCwpSJQ/QHi66/ZfSwhpvLcp2S02a8sOsLr+SNd+Rya6CYQPW/QCEM4kQIprlOyudjXQV96tzuFm+K2yax7bw0ssuxm7eMuvmRy5egg0WdNGgGVgUdAQWd0vId2rDWKUqFtRbmjYmjvVPAfip5jPnRpe/gIaI3azUEusylal/Hbx2HB/wvJ1NqUPQzU/qmHIF9xAWz2g8MjG0YAVxV4hpEJHLkLN5JHQkqja+xFgknvtEtRVc6bfgKxk/aw/slIAp82bIibzCjoUPuPYtmGIpuvcMQEqk7MAdKST3ktdamaxhSeq2LZ4iKGUTIuJoUnGDcRtaDgLisYsNqLXQx7vuaW0mV1Qdosai/PwqR1lRudammqkf1SdouhbVOt43ZAZaqeac
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(38070700005)(86362001)(122000001)(33656002)(55016003)(2906002)(110136005)(478600001)(54906003)(38100700002)(186003)(26005)(53546011)(6506007)(71200400001)(41300700001)(52536014)(5660300002)(7696005)(9686003)(8676002)(64756008)(316002)(66946007)(66556008)(66446008)(83380400001)(4326008)(76116006)(66476007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PK+CIx1G0lpoYE8QQtSwBtLPM/v6x0WKOKA4p6AP/R4Wg3XigQ1hHHj5Nh3D?=
 =?us-ascii?Q?jDfSfs0xZzvfepb6Vhc4zZlqNMEKv2f4iXBVyvSzha6m4ELdFsCOl75jqBjK?=
 =?us-ascii?Q?0mxlyuP3h8VqYEDpvspwnxK5x1YCrzaWncn2xmtt9lLxLlxi9nxRIgxNU3XD?=
 =?us-ascii?Q?tnujyiJIxu4AwTTMaJg1tKU5/0CwuALm2Sl5FKUZBP2FB08ose6RqRZnNzHP?=
 =?us-ascii?Q?KukOeqXKeCrve6fwCzwU0V8efrqE6AKPIq2zpEslHF0OW2XakmEpLJZ9yFBU?=
 =?us-ascii?Q?/vBecSCkcmPhM24+yk9hzag5uwAjYlnxvjDERvt1fJIpQH0enK8Z71sRoaWK?=
 =?us-ascii?Q?I7DxrsFOLE8yWQbZr0s8fMn3sVDPebbIFHJ3UlkSYyFRj+jXQDwgPl+rfI9Q?=
 =?us-ascii?Q?wDMCmtoTIoh4V8QZWnh0ptWj7WTHGrVbJuSA/JdjzSca4LVWeZGI6LVMBncw?=
 =?us-ascii?Q?EPL7KcR5W4pNlSwV201Zy8OUHaq7OF6RsXDDk0o4HH3yIpIqQIQ2fVNM3EMW?=
 =?us-ascii?Q?0THvKDN2YBKE6eJlN5L8YYaQz87NDBLbAKR+V614lo1dzMVcR6NKm4SdsgKl?=
 =?us-ascii?Q?BOsFoOGuSVEou16TNZkp+65CVef+V7EiWQ0So3lBIRHOLHZTF8Qx8l93plo0?=
 =?us-ascii?Q?3T7GrFzZXJO4GVBt6DJHNzcul22PEVyvEOh8ZElRJS/XMSEoSbfn9wFkebZR?=
 =?us-ascii?Q?I7QsM7lNmwwTd1nAfsrBBVq9bTKiZ4lI107cEXNgG+TxvsdBdqIi/yrjpi35?=
 =?us-ascii?Q?v2sI3hsJOig9TRwJzBXwvJoQbzt+QiwaUoo7OgSGRYjuE8ITGpAuTTSX12TS?=
 =?us-ascii?Q?u/x/7G6unbg+zcCodjEI2VuMJkRkNF8QbT1Sq+s7Hrks0LUMuTGBIqIPOmdh?=
 =?us-ascii?Q?euvV4SGg2ZZOAUwJL9xW92Ye0JUZp9i+orKAGYuW/sawYWorGiu7Ce+6ZQ/y?=
 =?us-ascii?Q?n1bLvwduC8KvUzQdjIDIb9C9WGu4OQDF9LDyRwhe/35/UBfehv6vFd9yxnzq?=
 =?us-ascii?Q?M6ExrEqmc7zzR6xxIhGMIYVPoKI9aTM7cqeb/dahScoHZiEsrG8h+HcwTAce?=
 =?us-ascii?Q?1H3k2a+OhpvaiJNDvSy5O1wYupxlmyeVDsK5IRS+vub5WAewo8V+MxxwDRtV?=
 =?us-ascii?Q?vDNj41L35d6xl/pGdpAFRSu6J0sKUo8RMiT/G4WETNtp4ZzMlQfiiGobMNbm?=
 =?us-ascii?Q?tnmp0ip3nGgjOKFERgFljxHxzGH3FQQeODZSeIwUL/dYKlBdj50cs+F7SHRn?=
 =?us-ascii?Q?A00mqbQs6Odr5rDUnxLDUKUpdmfpg9BFu+cJAp0V/IocLWg+rad4HjFFSIRp?=
 =?us-ascii?Q?cLmseilN/AzLuufykTgXEB3gyLgffjQ/jAdPDxdbxxuJVFDc1afWcjKNjYOd?=
 =?us-ascii?Q?NBK0+uRicDKkATX+m7YM/GynRRMca00pDLNkEgPz3wuJB5/DuQADHqOJHaSK?=
 =?us-ascii?Q?kOobSv22Aa+rXIIxmALdVWmC4Js2FWIp+wnRSpcfp+A0PxCZTTeZRBiYNNTI?=
 =?us-ascii?Q?5swYEEQIAtcSBsSmE+T5Gwf2sDXwjMMC+3GFwwSLxOjR0WAIAz2/PmiIudkb?=
 =?us-ascii?Q?+Gn9qvhicnL7fCVFkVc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910cce61-3d79-4113-10c0-08db8e456b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 02:01:40.4817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6X1i+cmWkLn0AhpaBTyvMRByoUA/0USk+h4SwES02LpSi/8cE7U3pxYVriyjTa6/E9DlMEuHwgRqehMtaGNiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Yes,  the patch title is " drm/amdgpu: fix incorrect vmhub index ".

Hi lang:
   You can update this patch based on the above patch review results .


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, July 26, 2023 8:03 PM
To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org; Chai, Thomas=
 <YiPeng.Chai@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping

[AMD Official Use Only - General]

@Chai, Thomas sent the same fix for the review if I remember correctly. Mig=
ht check with him to see when he push the fixes.

Regards,
Hawking

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Wednesday, July 26, 2023 19:25
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd=
.com>
Subject: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping

Align with new vmhub definition.
vmid_src 0 -> AMDGPU_GFXHUB(0).
vmid_src 1 -> AMDGPU_MMHUB0(0).

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-  drivers/gpu/drm/amd/amdgpu=
/gmc_v11_0.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 6b430e10d38e..9c4e084da99a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -102,9 +102,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_d=
evice *adev,
                                       struct amdgpu_irq_src *source,
                                       struct amdgpu_iv_entry *entry)  {
+       struct amdgpu_vmhub *hub =3D
+               &adev->vmhub[entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GF=
XHUB(0)];
        bool retry_fault =3D !!(entry->src_data[1] & 0x80);
        bool write_fault =3D !!(entry->src_data[1] & 0x20);
-       struct amdgpu_vmhub *hub =3D &adev->vmhub[entry->vmid_src];
        struct amdgpu_task_info task_info;
        uint32_t status =3D 0;
        u64 addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 604522f70d03..47f5ced12ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -99,7 +99,8 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_devi=
ce *adev,
                                       struct amdgpu_irq_src *source,
                                       struct amdgpu_iv_entry *entry)  {
-       struct amdgpu_vmhub *hub =3D &adev->vmhub[entry->vmid_src];
+       struct amdgpu_vmhub *hub =3D
+               &adev->vmhub[entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GF=
XHUB(0)];
        uint32_t status =3D 0;
        u64 addr;

--
2.25.1


