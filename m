Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF310C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 13:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6737D10E5D7;
	Wed, 16 Mar 2022 13:56:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9E510E5D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 13:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbttWwudPtitPTNPDp8eL6YSYWTZO8LTNqq79b8JjpjAmcI1reyTlR74y1g7pem2eFQXjYxkjakna7njPIUjn+7aimkGFQ8hu9AT5QPAQQdgCjg6eQBTNL06l/ypwvajrtfk8dSbdfKYEtF1MBFO5ukwUC1BWPQW14l65zmLJj9ubTxEia6pRp3f7WE8kdHwba1mL+J0+Jm/hd2BaCyafPBbMiztD6JMNv5fWW6Z0X3TvthhrWf25hasc+KqxF1OtqPp28KbBKFNDdZ0rgyVK7fqXMh89hJfSrGxk/0DXlYbSUOgg6by5J9favIc84DTLxuEf0Buz2CN9iU9TybyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GA9D18OOQINWDkYCO/WyuQL6x/PN6qq9O92kwkpW80=;
 b=gPLUQ2muNstlgawPOrwryvhm0Auf3q1vHqVr1jMa7HeCmeim6j22kYW3s8Qp7DBYUO3JJrfE1NEahPWtO/CS1vDPHB/L343ZPt7mvt2boC0zZiIkMSBKve7h7IjdFOjXH/tjTGgdfWgihz0nyZMBeRzG5cufI8zoBkRfY9iCjDoHSfyiuSeZd5NbIhNKQisemUQKT4yCV4HVBtansRlfCEUPH13DDyYuUdtnMCCX3D3NEMp/HJpTuofrwbPbOlXpfysUveFkUiYTlUjoul20N7Y+M2IGxUvF9i7XExZ2HnI4M18CjSkpZbdOOhwJmUgxhHGG9HjOIqMo2WmqxTb0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GA9D18OOQINWDkYCO/WyuQL6x/PN6qq9O92kwkpW80=;
 b=MXehBDwWhygWES0kn06LjPd01z+hLUXdfdq6wIaLyiTBn5xkRierOpOrP+WVN2dRu+3fTIBzlqWiwDib7Xw+F2fSz5/YgtN6cBGSPgEQ5ZPK0ET4GM2tKe+IIPidgw+hkS01YEEOzl/MPTmk7MASHqAn7/x5dRTLWZCm+uLJAGI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 13:56:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 13:56:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 4/4] drm/amdkfd: add RAS poison consumption handling for
 UTCL2 (v2)
Thread-Topic: [PATCH 4/4] drm/amdkfd: add RAS poison consumption handling for
 UTCL2 (v2)
Thread-Index: AQHYORf1zmp1WrfYGUKbkOQ+GkWO86zCCO/Q
Date: Wed, 16 Mar 2022 13:56:18 +0000
Message-ID: <BN9PR12MB5257A5D811FC1E8CF5A8C978FC119@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
 <20220316092627.17359-4-tao.zhou1@amd.com>
In-Reply-To: <20220316092627.17359-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=57147d69-d4e6-4457-8b82-0540b1d377f0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-16T13:55:57Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7d7dca4-0f26-407c-484f-08da0754bf11
x-ms-traffictypediagnostic: BL1PR12MB5111:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5111A61C1F171A112F054F9FFC119@BL1PR12MB5111.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QK8iCNkrQyWKngZpNdCHp2Z93yoWNeiFQMcTjBGjrfQPkD43QgiCfMGaTfn+gKFQue63/Ec/Ovrd5rJVWSuEr9SzXatKkUH5v43JUBc7c3k9COYlQ4IlqluZ8pxStC3qCV1rF+FlPVjYKzwK+DKAONWYfwRneLiw6+M/OaypTy0ZBhMo6n62fAb7MRgACrocA2VawbYVQ9zesM9iVCKsl+3GoA7mAvV0SaGAUKEC6UFZD+Jdyhc0vJMHnxoTgdRMyyOUtyaRmP5ybeVJsj8XUWm9X0N4/r/avAMpx0oKYMKhiiJHrW2fWMyA9ekisI3QIWP31PvQ9m8BeJ4fYp9xk4jrF0euQKBSPJNNQpkRCoatt037CZSYbyGiHo4oHTKc0RGf+WrnTDxnIcmPy+cJ2GpC1HKZ0IT2gTvxVlsEIM/IFf1nyq9xcVqz9MP19X2iVClLYW5Z+UnitQLUad27H4C7ZfdF4cgf10Ad9Dxvxv70b3ZcRVwSBFMyg1XoeX4QS0fTKLW3aYWX3HGwbUKS+zhSLtuD4Y33ykFK9hi11vR4jSoPcv2J4WrEBzmMkTEb6L9QFnT4demF66tx2Xdu5pwOwDL9yUh/E+C6e2gY6Haa/wgJflRpgDHYwwuOgn+HtqHupoY6HgIWMPu54tLtTrw/8ffEqvfe7chZ+mXR3j2tBc9cFZfPUaM+GAy49RN40aodQjW5Ya1QAxnrxP7fiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(55016003)(6636002)(316002)(6506007)(7696005)(71200400001)(2906002)(53546011)(38100700002)(52536014)(26005)(5660300002)(83380400001)(186003)(122000001)(38070700005)(8936002)(66476007)(66556008)(66946007)(33656002)(86362001)(76116006)(9686003)(508600001)(8676002)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UbF4Ph3Ewgbthc62/kqnPnanWdA34SO/MC81Mg+zotQlrvNGxZG/SVwFwdsY?=
 =?us-ascii?Q?1qaIwLB2tZLdJyDPT/gT85X1Cj7z+TnI9qppkmhOhFBKoJLPRUvPl1VUTerx?=
 =?us-ascii?Q?/bDSQp9f+4iApUVyQt0yvmeSiYU9QGPp0N6H8cODKEcFLakS89LxymF7L1yN?=
 =?us-ascii?Q?MzLWgrrKXFwe7Sm6irbTAz3sPp/KIBRP+qoREXxMtSD0h1s+yoc9fX1U+Qz5?=
 =?us-ascii?Q?mAZ0rE6WCVVyYrYzW8GrlG5iWKTtJLGdd0RvQ1oVKEWs5ArGuhgfxFO0C3Zu?=
 =?us-ascii?Q?yWNiYEDkTfTRU8qgituZ/Y6LZ27vbA9jOUUSgVITqE54S46Du7D3812Gf0l4?=
 =?us-ascii?Q?3K2rpsy2qEPFtMTwhMVY0J4fZQD1t3B0CG+ZmSiZoEmIwNm7plAA/fCvClKi?=
 =?us-ascii?Q?Nbe7B24cN8Zlq6eFOgGOUZAKH/lI1EwmVOSvF1sZCTCM7bVbMjhfBXDy/h90?=
 =?us-ascii?Q?PdGOhrydi0PptguE6TLyUTu6Kn6bjuy89I2BHnL7mUqNLeJ9CQfZIDMJQiHr?=
 =?us-ascii?Q?SDnDRVZU6Bhf2MBltqbaGbE8eMcG2hhnLq9o0OyP+C2c6Keb2GZbKqd4rRPe?=
 =?us-ascii?Q?8Y04o0QuSYuOJ8ntKqH06Lr21G+026VuIphekZtSwfHHD1zRgRKZFqaifLov?=
 =?us-ascii?Q?w9S35s+MgJkOLXklisuU0WMkiEXe3J97ToUuZd3ndN0dAYz7+ILEbmaVUUdE?=
 =?us-ascii?Q?QqTe4qWcK8nqjEMFsN1dZYHKHdolmxBAo1G73b//0j5dEIoJumxEd0b/nEzg?=
 =?us-ascii?Q?Uia5RxuhoPzFB4ko9lqwKzJhUUKCTtGUz+5CYF9oamYzI8QRaZGt9d5SwEzY?=
 =?us-ascii?Q?t53kvM+qu4a++iD3zIJ5wrVuJMUCPrdpDxeF8NA/QwBV9HYqUMZqqKRS+oAY?=
 =?us-ascii?Q?VM9TdiSKhJCuDg6RWm3nT56WvORINFHeVGSoF8HFVpc6OohnX879uZmb8B0b?=
 =?us-ascii?Q?hEnGTMmKARDcrH56TtMNtQttwHb98zFrQ9YbYTk+2PEU5G/c7ufwYZWrlHgc?=
 =?us-ascii?Q?20V3Ceqo/VFIDNxY/P+z0JtBEZPTahD3nZDleqq8UMj3YPJ9I155IJqz6DMS?=
 =?us-ascii?Q?bUMCNwm2rdOtVVPRo5Q1hqb0W+HjRUjYeRktpPMGfRFyIzGYa7DzKDrYkgMy?=
 =?us-ascii?Q?vv4NGbKXjloFI909kIjv68gpTKKQwFQ5wmWmABHAC7qUeXm14kLJ25C204C1?=
 =?us-ascii?Q?RWJDlLAB5Lb0BpVEUszkQMMZHZYD67hDrnplBshJc98/KxQlMcoIiRqVXdTS?=
 =?us-ascii?Q?e+toMth4GOa3pAvYPOrf/v764kD685me8P34Jodf5RhR6GzbxdyMvwTvrKOv?=
 =?us-ascii?Q?714jDOd309W3rqjq/UnGs+FG/u7FTDo8MWjalwISNIPlzwXC8cGogPOApife?=
 =?us-ascii?Q?E+5ZwBSoulXIPMBJ1R1H3aortM3WCoCx8IBLbLD6gLKOynYBvhFvTNixTHqR?=
 =?us-ascii?Q?/XIIjZB/VwCpwy3tKblfCvx4v2Ntvi6l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d7dca4-0f26-407c-484f-08da0754bf11
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:56:18.7918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byRtDygPhUlf+89l0L9JP9164wsSeYleymjxCJPv+2V5yIuiiLLre1fGxLiz5RqIpNeIggkjwFcaWBUYBGSBcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, March 16, 2022 17:26
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: add RAS poison consumption handling for UT=
CL2 (v2)

Do RAS page retirement and use gpu reset as fallback in UTCL2 fault handler=
.

v2: replace vm fault event with posion consumed event in UTCL2 poison consu=
mption.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index e5f03f79546f..55ee062a8496 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -312,6 +312,12 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                struct kfd_vm_fault_info info =3D {0};
                uint16_t ring_id =3D SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_en=
try);

+               if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2 &&
+                   amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev))=
 {
+                       event_interrupt_poison_consumption(dev, pasid, clie=
nt_id);
+                       return;
+               }
+
                info.vmid =3D vmid;
                info.mc_id =3D client_id;
                info.page_addr =3D ih_ring_entry[4] |
--
2.35.1

