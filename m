Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF22AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 10:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3787110E1FD;
	Mon, 14 Mar 2022 10:39:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF8A10E265
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 10:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl+uaHWtN57hb42mA4cR17JP0Ttlq+ncFb1RvV+HbZc/zaOpDxd6Zqx1OPS/08C12hvUjkI9XQMmpv7rZvExlhvbbTjTkygnIvLAsMbLEgCvsH4//ln45B4aR6xVOo+GQIiLR+0WVUST6bhTC2nPbST6KRXS8eV8qH7H31cYMMKhDoZqUSE0qDmbn4E1V/pQb00e3ul3zO0QeJJCq5pmVqrvGInmdIKK4nNZ2HxqfnCpfMwk4677S4m5OMlCOd676zr78idm0gqLk0oaIFT9B5pwcrC+NNdEfSNnoE1XKtEtLzYPwkkXtJ0MsMEgJDjP0YX8YxjzGtC26rcYA/IDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEgh59e5e+EPlCsmfduKyDVyj4eMz0i1nHmo0O8o2oc=;
 b=fsoE4sWXNd1UUc66r4nDEuL8T7ZRfg+o97ram9Fmn50DbLBvZ8pV4jPhPOcmViOWQlNzxm2VW0qyvpy4hcq4IgpLGXLCRTaX2RRau2Ykg7KMz6DSsDVtWIf9xuYaSc6LHmn52Tg8teMeL45gw9HfocTE5yNFB62uwoIwSy5qNc0/D7tTaBniXQpHlFMtRGVMCqtpJw1Jj+Ranxof3xXi4hD50ffi61ZaKUK/qr75ar4/aJH+hx5nS/PojoEGdgF/x6qPb47bIYiuTKKSey3clbsuukqYGYPOV3B2He3vlqogdp2N1HPyBkttRDek+JGjgbafR9TEjGzghtGxi9qgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEgh59e5e+EPlCsmfduKyDVyj4eMz0i1nHmo0O8o2oc=;
 b=JuBY9cO0CfH84jNYSRp8IbULzCwO7BvB5J/ldwJhWPRumSik5aXCYpzrTFt3MbyEbH0LWGEIpXRa/QcbTaVzLq+E3hnv7da37xJMOO3flh8tC0ULzOKI79rHD/1huiXbcmXwYKwKt4RKVejyM3r8zirGqRJ42fSuDA7HjT/7F98=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY4PR1201MB2484.namprd12.prod.outlook.com (2603:10b6:903:d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 10:39:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 10:39:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Topic: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Index: AQHYN3Gn/F5FvmCiqEWMn/gd+mdRFKy+qjPQ
Date: Mon, 14 Mar 2022 10:39:43 +0000
Message-ID: <BN9PR12MB525751E2894B86B3E75ECDE0FC0F9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
In-Reply-To: <20220314070326.21828-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-14T10:39:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=67cd1c3a-c2f2-4376-b25c-6a09633070c5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 825f7cac-32a6-4762-df4b-08da05a6f3b7
x-ms-traffictypediagnostic: CY4PR1201MB2484:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB24847DB86705752FECA8BA9FFC0F9@CY4PR1201MB2484.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Bn1mZtpoA3puzSu9E+xbcGpUO7WFnqEvzrBuf2Op2vKoqps2L9ZvVSL3CLj7ZYIYMNM7koObOvmkJjnncbxikRq4NUUg3gz5DpoVSTPDgdLvRo8jJ1ZGOSACg+ULR+LxC/3u6rtfStO4vmX6m7xVIBbDmlb/cplHDq9uKp/7Ps4dOgoW38g5XWposBCL/zqtYTKvlHRwXmATZzwkf+4RZio1APiB01+bFjJpjjvI3Z9lq2I1bo2kz5F9ilwgjxL3TQ6mOKYcf3rdcfvWLFAb7aya0i4GK6GgAWZq7y4BflnUDjBpGOjSk2E0ENjRdjT2d8OTgckO7oy6mtRGihjrKmMKd4olKUdP0m0cKo6ATk4HoIrI49qN7eMAzRCiAjfDVCqN7BbLt6uVdQB9h9blCCrnZoH/VUc2k2YmQGQC4IVSD1fRbKKnFIb21pYOaoKWmeI7o/30rYqo2YdqpxVsxBfB7tFJWTdwhUskBWMQ0n55RNUOcSsPZxXVUzfD0MKANcVR+TsmqeHdETR9MUMkJ6pcXNaXlhzTJ/IEl9uyByb1Lpft9NZu3oF5BsPkH2AE3D3abNPnJyB7fqHnVakWwEWbzr6VD2ff+l2Pk0qqEPWHlm14a96zzLf5/CS4df9+HnetOstF+me4Ge/kD+w/Co2SYmF0UsZJKW/KTnWSBEccVA6kr4rjv832GkC41xZBCxgBw+26L/d8pMTm+iKPg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(7696005)(38100700002)(9686003)(186003)(26005)(86362001)(66946007)(76116006)(66476007)(64756008)(38070700005)(66446008)(66556008)(53546011)(83380400001)(6506007)(8676002)(2906002)(71200400001)(55016003)(6636002)(8936002)(52536014)(508600001)(110136005)(316002)(33656002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mXbIu9a1E3GXrCYTclS3LXIwPsU0YVTWVi4EZCkFEM/13dv6YKdEEZfJRnWS?=
 =?us-ascii?Q?fEla3ILtGMQHzjXWpCZYGgw89XXgrSzwDVmgnnPOjYb7zaNLzf5byAZj1kRn?=
 =?us-ascii?Q?sf4wvUjXXhXWbtljAabHB99KgOZWzfae74qf72+ACnJRcZBrRW2T0HKtJlt6?=
 =?us-ascii?Q?lYRRx2iTov/ng+Dyx4LGAwwi+Gtb2sSopH2IVcyghDp4iOEjZ1AChV/oZTnk?=
 =?us-ascii?Q?/+r4cwz7m7kTknNcgec/rAE2wpTIH5JzOGHZexljYaUtyJpcLw86ISdHxEIr?=
 =?us-ascii?Q?+CYwgO5gjtEbAbZAI05T6XWfydOGkNlgjr3G1nYTx/Tpm7fDDpF0kdt8STQH?=
 =?us-ascii?Q?RQ0HU9ACp7SrKg9ZOy/HDWSFUYEbZCsj97Y4Dvd+L/2adBLTBnoOJaknRMWe?=
 =?us-ascii?Q?EdUddgpMv8X5peaWsQhMNKtRYyexLcqdQw5PYScY0keVcYUdmHLM305nyX0f?=
 =?us-ascii?Q?OkXvkagiTsOHKHEOEUC6zuVG0LpycViHMfB9NxAWerPMTtG0havjbePYG5ov?=
 =?us-ascii?Q?iqqo++mazBYa0Gxaqvl/5TL2JRFvwWMwHgKgVVcsWvdejuYtSWFiwrEvHlTK?=
 =?us-ascii?Q?BgqSs+3X47t2NosdyspFRld10XmtT4/s8GHYRZuvKcAJfLm2LeszwFOuz7f1?=
 =?us-ascii?Q?BpZiADFfoFtINHZ5hfPldKQZNFzwMaVDoYqXr97X2wbZ6HKDFx2CnYPWbEL/?=
 =?us-ascii?Q?EUgzXizRJ8ngdT3QQo4COxZ2NK5c/cVcytquoSxmNdZ3+eAIME8+2PIq+Bcc?=
 =?us-ascii?Q?Ob5MOuEiuARtq2uV4bwd2now+cIwy+GqRdVgneLzFcUB+9RpgYpk5tMKvQKC?=
 =?us-ascii?Q?cDGa5d3WFH7XLB68IBYGCkvqsVg0JXzW1GcNX1L/ogEoim0svBK6/lDusjye?=
 =?us-ascii?Q?0epRrXJPqapAyUwXdUWdALc9Y/iphMp2QLJgVhnIT/15LGjXnwNDrqqYG5q/?=
 =?us-ascii?Q?kkkSj2xrJAE1Ku7dOyb5WJeq5Wjps+JkJxd073Eb11/zgjgkQq5tPlKkv+xj?=
 =?us-ascii?Q?MS+OgIxrfKr4vZSZ18kpLMY7gnm1GIdmYbydGzUwRJYiTbZSTrUnyfV20Vt5?=
 =?us-ascii?Q?+Fp/QKcfkL1FLJtHzlty6SW70gNs9wv1f7+ipx+8wWX0qf1uK9cyfHNm343z?=
 =?us-ascii?Q?f+m+csms0bf9qgRIvlVlTnQFdD8ZMm+lA7VxbIlzN18GNth7X7QR7jIyWkAu?=
 =?us-ascii?Q?+jyIcQfGDZ0CwIWWScE1oQyn47+XLiUIY7oUFaWyb/MLM/Sly2HlleQMP/nX?=
 =?us-ascii?Q?u9uy6sK1h512BEW8PNk5GqJSR1VelZIX98qioFW1Q15DGBwn1dBh8FbqkB3j?=
 =?us-ascii?Q?HLpJ0FJlSuoddskkfVdEFumeOuAbgulIDrCd0D+YDfQlozOLq1pV6geCnFlT?=
 =?us-ascii?Q?wWl4UdbiGP+oAe9ZoAXNcU80zOj9Lj7jSAF88DxeD1mKvV4TNBPH7B5mINCH?=
 =?us-ascii?Q?bQ5t0L4l79sAOHqMrmnRAVKxDjB3TrYE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825f7cac-32a6-4762-df4b-08da05a6f3b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 10:39:43.7032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Es06JYnC8IgqbO7EUv0npdO/M7h8darHxh62zT9poYh+ZDzprcMn71kEwSqpzUjBR09MgHHYzihsn3tML+ue9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2484
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

Copy Felix

@@ -119,10 +121,14 @@ static void event_interrupt_poison_consumption(struct=
 kfd_dev *dev,
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
+		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2)
+			ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
 	}

This will break SDMA - We haven't enabled optimized poison consumption hand=
ling for sdma yet.

I'd suggest we explicitly call out the interrupt source id UTCL2_FAULT as a=
 case, even it is the same as VM_FAULT. And it should be fine to start evic=
t_queue directly after that because in ISR it already guarantee this is fro=
m UTCL2 client, right?

+		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2 &&
+		    dev->kfd2kgd->is_ras_utcl2_poison &&
+		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
+			event_interrupt_poison_consumption(dev, ih_ring_entry);


In addition, is_ras_utcl2_poison can be renamed to query_utcl2_ras_status o=
r poison_status, while utcl2_fault_clear to reset_utlc2_poison_status to al=
ign with naming style of ras hw op.

Thinking about this more, it's better we add this in gfx ras op, and expose=
 to KFD. Thoughts?

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, March 14, 2022 15:03
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for utc=
l2

Do RAS page retirement and use gpu reset as fallback in utcl2 fault handler=
.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index f7def0bf0730..3991f71d865b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -93,11 +93,12 @@ enum SQ_INTERRUPT_ERROR_TYPE {  static void event_inter=
rupt_poison_consumption(struct kfd_dev *dev,
 				const uint32_t *ih_ring_entry)
 {
-	uint16_t source_id, pasid;
+	uint16_t source_id, client_id, pasid;
 	int ret =3D -EINVAL;
 	struct kfd_process *p;
=20
 	source_id =3D SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id =3D SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid =3D SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
=20
 	p =3D kfd_lookup_process_by_pasid(pasid);
@@ -110,6 +111,7 @@ static void event_interrupt_poison_consumption(struct k=
fd_dev *dev,
 		return;
 	}
=20
+	pr_debug("RAS poison consumption handling\n");
 	atomic_set(&p->poison, 1);
 	kfd_unref_process(p);
=20
@@ -119,10 +121,14 @@ static void event_interrupt_poison_consumption(struct=
 kfd_dev *dev,
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
+		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2)
+			ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
 	}
=20
-	kfd_signal_poison_consumed_event(dev, pasid);
+	/* utcl2 page fault has its own vm fault event */
+	if (client_id !=3D SOC15_IH_CLIENTID_UTCL2)
+		kfd_signal_poison_consumed_event(dev, pasid);
=20
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution @@ -314,7 +320,1=
8 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		info.prot_write =3D ring_id & 0x20;
=20
 		kfd_smi_event_update_vmfault(dev, pasid);
-		kfd_dqm_evict_pasid(dev->dqm, pasid);
+
+		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2 &&
+		    dev->kfd2kgd->is_ras_utcl2_poison &&
+		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
+			event_interrupt_poison_consumption(dev, ih_ring_entry);
+
+			if (dev->kfd2kgd->utcl2_fault_clear)
+				dev->kfd2kgd->utcl2_fault_clear(dev->adev);
+		}
+		else
+			kfd_dqm_evict_pasid(dev->dqm, pasid);
+
 		kfd_signal_vm_fault_event(dev, pasid, &info);
 	}
 }
--
2.35.1
