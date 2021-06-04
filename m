Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52B6C4708F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 05:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70AA761263
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 05:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AA761263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1771F6F563;
	Fri,  4 Jun 2021 05:16:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FB46F563
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 05:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qbu0kgCkJ4pJUVgjWOKYmAl2mLrL7fgKhQYc5e16ceURF+1MxbBa7IMR2EbgdO35CoAQ3bf0NrDHHxv4IT9RkviUMTqTSggNGiGUqaaArqTZrTsSor4pSLaUYC9lDQPoA2Kuvp3mnToXeTrTazRD8TyqUGSCcM/s+5CPTiOF2o+oGchyxe1PfsYOd27ogR7wZmraJblOsW9SUFV6Ur5nja1ncdl0BpebwszHXm+oNjuO0wxVtoQYVnp43CmrvdAQiMy3irW9Foim+Htmi2v5an5Hb4i6imsup2aM4RhV6xIKHNIUgMh3pXqgwAI7OeSCM65t4k2OeyiXuxtzQB1iSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR1JWfY7kzdodQm5cj0ZGTu1dLxVqDO/4Jpj3vc7Edo=;
 b=fqYVwKePmxFDMx0Gpt6lpVHmPh0YB2gvvk/rwM8lLrvZneOeOAgSQ0H8W99MJd8VUlc3bC/zUfunHu7236ov26IaR1CZbDF5g2ncOy5Kq2FFfDFbJS97DH0q9m6j84e7ey5im39TSVLeYVKO1D+ZpBxu9glaVMAYIX+yTvz2BSS8UHVe7OByD8E2UtZLanCglrjC/BSI+tySancFHakYYYjTZ/B/i42jF9n+9PHn4Su7mMoSebdrlZlT3/z149gw+m7usJ3J8I7Fzi13SdHz+KQbKiTFYrMdt92gVtNpg4co7g+CIdXzVwf2PvM8t9g6QSz8c+Kwmwov4l+IFlSrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR1JWfY7kzdodQm5cj0ZGTu1dLxVqDO/4Jpj3vc7Edo=;
 b=P5Ngae2yESe3Bj1LgSrW6OL9wjY9wLn0sQEt3q63nh9pxXwiEL2AgSGUcY8VSc52+BIqeJyMg282Nr2GsQhGUFlRhPVs159wYhp19E/4CJeR5+psP0fSOD2ebxsdTfeD4p1ybyEKUZ5TxWnK/jaOoM44CP5xQU+oh14NfOiDUH0=
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 05:16:27 +0000
Received: from BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::6d4f:8380:25da:4824]) by BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::6d4f:8380:25da:4824%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 05:16:27 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: add sdma poison consumption handling
Thread-Topic: [PATCH] drm/amdkfd: add sdma poison consumption handling
Thread-Index: AQHXWP5ITsTGYKUCC0WpWa1YjTGia6sDT2Bg
Date: Fri, 4 Jun 2021 05:16:27 +0000
Message-ID: <BL1PR12MB5350DFEE251E5ECCD8D2A20AED3B9@BL1PR12MB5350.namprd12.prod.outlook.com>
References: <20210604045821.14486-1-Hawking.Zhang@amd.com>
In-Reply-To: <20210604045821.14486-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T05:16:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8093a411-711d-4509-9490-a03e4f03edf5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10286d1e-84f4-45c0-5e66-08d92717e791
x-ms-traffictypediagnostic: BL1PR12MB5221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5221162D41A5059AD3A2B886ED3B9@BL1PR12MB5221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDRDuJsfT1wZSIO6wYk3I2YjjhRt3LmaRcHeLBekGJVmGcaxsRdtcpeJQtFfVYMhOUicxtALfyRRqK+fHmMqiXBNzUNGhrWCeZ8eD/OzXDn9XBmWNTkYKxY/g57L1PiuHAOsdHEt2IIu+tM/uzmqkbC8Dakh/svi9z9UITFNlVyHwbG8gVwmT4gE3KX6mSqjb9lFeFB/cNgdr7KToXbKlt//6MLXGvkOLxAIO3sbU2B2kJGWTCkPTM81lvAQUlG8FOD0iUkCGN+20ryv1uJBOcl3mMCCH0xQK0gloBqxuPh8St85vUvyogWexjU7Ef25H1s2xvpisiVsvYCVGjO1jdvXZl7AKNiVfNw4vyz3L4fn3fiYhPwSD6ghn7+Ku3OjLC0qx/eyz7kEtCN5JFELW7OgZZ6/KKBDN3wKDJW1BGG3NyPtFyGExztyCNPE5PDG1Zp3GN5yHcSoXDyOitFovTScToCfJabsHOmW01nzms6W3BYwOZZspPLPcyXcQ2biIteSKdpAvWrnkiorSFDqlu9HGiNqK3Zw1F+OTvGA4JKf8QWdMkMCveLf5QaVzVk9eilXeC9EyHZ3KV32lotaPxgOeN88W2AEIvHxHFAnKUk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(26005)(8936002)(8676002)(186003)(122000001)(83380400001)(38100700002)(2906002)(316002)(110136005)(66946007)(66446008)(66476007)(64756008)(52536014)(71200400001)(9686003)(33656002)(6636002)(86362001)(55016002)(5660300002)(66556008)(6506007)(53546011)(7696005)(478600001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?K2NZRHpiMFZkL0hoeFUzUTAwZ2xldGRuQThrUzBJRm4wMG1XVjNFQXBWbXVx?=
 =?utf-8?B?Q1JvZHFuVW9LU1E3Z2RId2FmUUlRSkVoWWpjOFArUXdQcHRRdGNuYTRqU1U3?=
 =?utf-8?B?UmlmcURnVHU4bE5hT2ZldEVUL3BoeG4wbUJzS1dBcE4wcXZlVkw2YnAwOHlP?=
 =?utf-8?B?Z2U2dUlPbmovMk9yK0R0NTRGR0tsT1lNUWEwVjVyRWx6MWlCOGc2R0Voa0ln?=
 =?utf-8?B?ZjhBcW5BOXQ1MStsOThPS1J2ajFCMGxhRTBPMWpwcXJPZGx3S1ZiL3AzUE5M?=
 =?utf-8?B?dUJkSXFhU2tCOHZRTjBmRkFtUk1mU1lwM2I1RksrTE0zbnRJcVJxcUlYazM3?=
 =?utf-8?B?SkQ4eGg5SFJ0QmFNWkZITHU0QWFKNW1EUStWYUI0dlRnQXFUMkNJSDVFUWp0?=
 =?utf-8?B?bFc1NXZoZUpGeS9zNmxEZEk4ZnRNek93TlZ6NmRGSjNBMUZlczdBOEMyRkFi?=
 =?utf-8?B?ZkhtcEh4YlU4U21aM0FKTEgwajhUeDMrRFJ4U3A0MkRJR1FHQlBYdkxVV1hv?=
 =?utf-8?B?SXhBK3RLck1lTTF2SzZxREQ1VjNCTW1MSlF5V21ZUlVEMjRCbGxUN2d2aDh4?=
 =?utf-8?B?eUtrcjgxWFJPL2sxRG96YWVPV2ZFeWtDK3FKaDJPQ1pNZ3FDQkRKSTVMRnhQ?=
 =?utf-8?B?MTF0OVVhYUtINDRwYWVKeTNtYW5XRnRiWXh0YlplTEd1bjZjdFJNcHoxdW9u?=
 =?utf-8?B?WkhwVHFzM3FKaGY5aFBaTVpIUTlQTUViWVdBKzdnc0RacFVlNzdlaGIyNmtY?=
 =?utf-8?B?WWJ0b0s5MHQrTXlxa2x6MUR1VmFSNzI4SUwwb2hndHNVOVExVUJ2a0tVeXBs?=
 =?utf-8?B?b0paRnJMWkg3M3pGNmp3dTVScGc5TU55ZzRRcndNSnlwUSsyNldBa1dyaWlK?=
 =?utf-8?B?eWlja0ZsdFV2UlJjbDFTaXlBd0lFVEtKT0RBSlF0NC8zWVBWSmc2YUdlNSsv?=
 =?utf-8?B?TzM2TnBKdTFTQy9WK29xblAyMXJ2enNNRFhHQWxnOGo5WHdQRUNZN2xHQWhr?=
 =?utf-8?B?K3dDTDlFbTU0N0VCMTZJY1J2UE1LWlBuODhjN0h3cCtxRHdEbkRVR3pBV094?=
 =?utf-8?B?SU83ZGc5ZnVud0VNRUsvYXhmei9vZ3ptWkRNK1AyZXVCWkdkSkNLZVBjL3Ns?=
 =?utf-8?B?clczcHd1Z2pJdjU3MHVkYVVLdWhrY2VacllqQmkvc2FjZzkvbUdRWU1nVWRM?=
 =?utf-8?B?bUZVZHBHWWp3SWtZUGwxWWw3dHVDdWkwbkNnT0tsWkNsclVoaEFlTE5iMmdl?=
 =?utf-8?B?dFlZR3d0K1NtekNQSE5HWWtxN1VZdDdxWUZGcmxodlM1K2FyOStVTWwwOEQx?=
 =?utf-8?B?M3N1bVhnSjhFbEhSTGdaNGR3KzNJejNicEpXbXJaUUEvMG9aL1M5NURpMm5u?=
 =?utf-8?B?SjdnZDE2YzFicnlqUzlPSDBjMzk4SHNLUXd3aHpuQTV2RzRFM2p5Y0svOTEr?=
 =?utf-8?B?R2d0YjBaMEZvdTRROUZlaWk0dHovM3BPbVc1am1NZjB4b2ovVEQ1T2pHdkl4?=
 =?utf-8?B?bHlUWERGR2VqT21WNXU4RkRObTh5QVlSOUdIZWRGQ1EyUk9VWkdXNG5jUGZq?=
 =?utf-8?B?S2k2cVpzc0VlRGJqN2g3MGpkNVNURjMvMjZ3NjhzRXBqaVRaUHorZjZaNmx5?=
 =?utf-8?B?bzdYakxMTHM4SmdlWlZEeEYwV09HRWtTdmxGZ01uOGtMd002bndFLy9YL00x?=
 =?utf-8?B?Sy9vMnp0NUxjUC9xcFpZeXJ4UWl5MVRUenFneG1NV2RTaGhYQ2JVQTA1UGZE?=
 =?utf-8?Q?3hIURpzagSX80SqyEy5ovkH905AVwhqU1hywfUi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10286d1e-84f4-45c0-5e66-08d92717e791
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 05:16:27.0648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GadzAvjM2M21gBQ7UNhgNQ5D3RG3KMrLG/nK+puWd9h/w/Jt9nFvmY7q7x6RJR6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This patch looks good to me.

Reviewed-by: Dennis Li<dennis.li@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, June 4, 2021 12:58 PM
To: amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: add sdma poison consumption handling

Follow the same apporach as GFX to handle SDMA poison consumption. Send SIGBUS to application when receives SDMA_ECC interrupt and issue gpu reset either mode 2 or mode 1 to get the engine back

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 7 ++++++-
 drivers/gpu/drm/amd/amdkfd/soc15_int.h          | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 02dd12774261..2e2b616c1bb7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -309,8 +309,13 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		   client_id == SOC15_IH_CLIENTID_SDMA5 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA7) {
-		if (source_id == SOC15_INTSRC_SDMA_TRAP)
+		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
+			kfd_signal_poison_consumed_event(dev, pasid);
+			amdgpu_amdkfd_gpu_reset(dev->kgd);
+			return;
+		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
 		   client_id == SOC15_IH_CLIENTID_VMC1 ||
 		   client_id == SOC15_IH_CLIENTID_UTCL2) { diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index 0bc0b25cb410..daf3c44547d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -30,6 +30,7 @@
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
 #define SOC15_INTSRC_VMC_FAULT		0
 #define SOC15_INTSRC_SDMA_TRAP		224
+#define SOC15_INTSRC_SDMA_ECC		220
 
 
 #define SOC15_CLIENT_ID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) & 0xff)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
