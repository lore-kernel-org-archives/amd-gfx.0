Return-Path: <SRS0=9dkd=HU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF2EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 14:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989AF64E76
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 14:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989AF64E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234B26E839;
	Thu, 18 Feb 2021 14:33:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F5D6E839
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 14:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip7Vt0ycIfNniBkHjzOsTDMqNCUTS0ZcmQaBks7Z7GoDTWU321VqA7w3U/NaMCEnOR/P2Q43EYCNVX+uX4PxHzzL0gpMGLRNz5zrRfZWmlqeHGrI7RG99drgtIOy+FUKzIL1zjtUdLyptamtZi4YlVF32jWUiRVom2hJVslUYgcXsQyykPvtDUzZdZ4wngc2RQvoS/OSqi7mhIoTJlXvPIr8kfl3Udb360DX0XB0Zo50aIU/XWmG+JqFVNTnoiE2iLhtKBctMfZ7eEPKWU22x6Q4g+bZtYxKa0IbcpZBM5SiRLpP87JaSDTl8AKd0LqgyXabS7s7SOyqhLkgp6unSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e4nL6MAIUd7Ei/XIlGXZUfGPYSNRP8Fp7mS4XX1dlc=;
 b=NVFo1jXqb5iZMUXmQgbLad04JiuVJgaZ5glsxNUsAnfzD3k2Utd3A/EmOftHIMY6UdVXrSybcNiNbf6qmoUNe7TPnqrUR/pTKtb9oox6fPiWrIxlhEPewo+VCNkaLMOzwmn7QDXWdLyeBVm+7Tx36GelSdAyKBWLRodOMhW2uhjSwQyu38UGbUbUL/2RYGY5QBLiLyfTpyJ1ul4Co9q3thOP8436XkScJnlP+c/nhgIBPufsZrza6f9JFD/+lPab0+bqO5ksorv1ekiOPoQ5WBxFjAb+c/ruEbDOHM/eTRE2ytc4RHwI/b/058AJoKO46R9hRG1d4ePfCZNaqLltpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e4nL6MAIUd7Ei/XIlGXZUfGPYSNRP8Fp7mS4XX1dlc=;
 b=p30rok52pwlWb4AD6jhYryAJO0x2nIVrMHZGDKgETlt6fkD9Le9xheQQAjNQTwUU3B4GIHobMTUP6ct/jzlYH+y7NLzI4dI5yz+MNOdbwA8RlDRt9hwD9uR/wkeUxm2T5pnWLG/gTNiJOxs7i4f/i9Tyfad3rWDnLC4BDFXT4IY=
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR12MB1721.namprd12.prod.outlook.com (2603:10b6:3:10d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.26; Thu, 18 Feb 2021 14:33:50 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::807c:1f17:9a40:51a3]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::807c:1f17:9a40:51a3%7]) with mapi id 15.20.3868.027; Thu, 18 Feb 2021
 14:33:50 +0000
From: "Jiang, Sonny" <Sonny.Jiang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share
 memory
Thread-Topic: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share
 memory
Thread-Index: AQHXABWvRnGvW9O6cESBIamBaOFvsapeBfKy
Date: Thu, 18 Feb 2021 14:33:50 +0000
Message-ID: <DM6PR12MB3433F0538D298A0069DE0D97FD859@DM6PR12MB3433.namprd12.prod.outlook.com>
References: <20210211013109.16781-1-sonny.jiang@amd.com>
In-Reply-To: <20210211013109.16781-1-sonny.jiang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-18T14:33:48.497Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [67.71.205.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27c2f6f4-c122-4351-5d17-08d8d41a3560
x-ms-traffictypediagnostic: DM5PR12MB1721:
x-microsoft-antispam-prvs: <DM5PR12MB17215A2C5F305C82565E2DA9FD859@DM5PR12MB1721.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHcljeFlv+C4/aCLWLbo3YxHthec+4Tp/NDDo7NloMC6udJcObALrL+hhxFKDW0NiFptwA3cYWXmja7RbKBy6kgOy5CNyshxBbT37Ksax3pcSQb0V1rTdrFAVKJQq9mNgT6lvOo+lZC/KJcQ0zsWYjctPCAaTpXT0Usz8DWLR+whkudvaD18jDMlxDCXrF2qIyTz8h4vbOUIHhwYdINkoWQWAe8nQhRAoy7l4KJNsErFnW+2ZVXLoOF7MFZyitfIBGaksmqhoBH3r8CobFiLpsgZ9Y/qQOSLwzeDA+U/bOQbfFwEvjYT1JsSSPE6o3JTtJFVlNldkBFtXe5I03LsJ/f3xtcDZ877tXQXoOFOJALb4fnmlx29anMbLRmP9wuPTz7ciJR+UXEPguuxGMoUlRb5BvCwaWPhxIix3W0MwxEVVaaKoVthWezgUWpbQF4nTc0tEx6TiRkPkjnS1HrJvz0CX5j2s5A5jvuanDY1Vft3dFgNDTfkcMRbiI2GmQIsTiRReVQJucXSy4KghRisgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(66446008)(478600001)(71200400001)(19627405001)(8676002)(76116006)(9686003)(186003)(55016002)(6916009)(52536014)(66556008)(66946007)(15650500001)(7696005)(2906002)(66476007)(53546011)(5660300002)(33656002)(26005)(83380400001)(86362001)(6506007)(8936002)(316002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?86eqAK5NZOOMh6rM5nnvAaEY8pXLGquzZ7TV/Td7geTk0XIJtBqrCLK6ysB5?=
 =?us-ascii?Q?nhKwRqBZzUQdTvOugSe5UZnyAijCbDxPCLrRoJ16/Vo5keGS8G8yW3FXwP9z?=
 =?us-ascii?Q?BrjnIGtCkF54a26I3zvjoa64n6IvYtSmO5ncHJaTk4WO84GyaBR4TaY8J00E?=
 =?us-ascii?Q?PewxqzXImvKqK2Q7Pq3aD8GctGxf/SYdcSi7hONUOj5zOpwXUVXWYLBFZIMJ?=
 =?us-ascii?Q?pTh5gNeVHop0T7x8D8B5VdonyGTNfl/cRrIpZYbtugd4V9W8u3q9cW2AdRSQ?=
 =?us-ascii?Q?A2GzqJGo5Arbg8mm0fY0EFFdpFFuqMc+GNbAckg9yD0CKlbWDZPgt7cpf662?=
 =?us-ascii?Q?a/4ZehNz+6R5HPGvg2lJda/iq9wzvL2yOfaZFYZWwx/XNxFAtBdB1ILHlsKR?=
 =?us-ascii?Q?SG2Bz+/8/1h24DQn/AgEPTEv8vxNgsn4EAYyJdHn7hBUSQTJvj1xwG4xzW8d?=
 =?us-ascii?Q?n5vQADJT0a72ZTyRHko1wLe0YmeFTkgPj3yTaLr+cGJoCyDESriRMWuwOJeY?=
 =?us-ascii?Q?O/WBXMHV2CYsiCLByDDkA5BJQL4uyUgr9fBvHC0yvcUmkg+OM5dVcy4QSdnG?=
 =?us-ascii?Q?QlEgsNGlub3/WK5sjxHPetZkL6f4F7jWUIOY85gBtuxwcHGeEkIq8FD4LecQ?=
 =?us-ascii?Q?0UD5n+COuLyPAfdR99b8OkSy6GTQ0EM7iXcxTQs3UtN3ZzUYvrir0c9DMZgn?=
 =?us-ascii?Q?9++E7p1NcL/DeiA3phZKLRZzE/yK+bS15txLyb12A7xyGzquXZQMzgu2akjH?=
 =?us-ascii?Q?zQrYlw+Xws8ehoR9rElTbZK6XfK+FTcoXFy7PgRHVtp6EbdrEyjGzgeS6pXX?=
 =?us-ascii?Q?U/57nJG0WHAreJIuW95Q3iTz3U5iETNqz8kA+EZa5mDEr9Fx1qaD/v58TKWe?=
 =?us-ascii?Q?3Po2HENUdfDnTdRdXQdTK+HS5GUljPvamETP+YP5+DiClG3ZeY1uzFZufvaR?=
 =?us-ascii?Q?yU+ADAFaN62qU7pGKERn8cuNJVvHfigqFBvGGOmLnsJ+USbyklfTi35slZgy?=
 =?us-ascii?Q?hOFNerdOwWK0fvA6tCDg9YC0CGy3MrrXFrRxWgK0SnB3eeZm2ddvqpTfT1go?=
 =?us-ascii?Q?2/jdFT5HhDojVGzdqmGo3MTDIPE2GiRTO2SoNpPvzoVGse4C673SzPOIlcMh?=
 =?us-ascii?Q?qyd7Q1TpUDuopSFmMzk6DyHGkzAE8Iuc5DFDivVXLwy/iTVVMV9AXTJEvbs7?=
 =?us-ascii?Q?sVabmjUKsov5VqpYpvLHvpgiTWazww8dmKgAvnUThtQlLwtS4ELRtNsPeiVu?=
 =?us-ascii?Q?HCToDy1Binsi5Nk5y3q1ywzC3fD6Mah3IFI5quMOfD+PZK/MxIRdMM8HX/c5?=
 =?us-ascii?Q?2DU=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c2f6f4-c122-4351-5d17-08d8d41a3560
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 14:33:50.2191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hKOKAjsoWt9HhdDNwxAko8Fuk1NRMfHukxd7v4faavaDmAa8HbtpbwdTPVwLGzAm1ay6G82Tivl8+FA4vskfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
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
Content-Type: multipart/mixed; boundary="===============0466987826=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0466987826==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3433F0538D298A0069DE0D97FD859DM6PR12MB3433namp_"

--_000_DM6PR12MB3433F0538D298A0069DE0D97FD859DM6PR12MB3433namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Ping.
________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com>
Sent: Wednesday, February 10, 2021 8:31 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share me=
mory

Because of dpg, the rptr/wptr need to be saved on fw shared memory,
and restore them back in RBC_RB_RPTR/WPTR in kernel at power up.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 24 +++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index 13aa417f6be7..a19c0c35e2d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -155,6 +155,7 @@
                 }                                                         =
                      \
         } while (0)

+#define AMDGPU_VCN_FW_SHARED_FLAG_0_RB (1 << 6)
 #define AMDGPU_VCN_MULTI_QUEUE_FLAG     (1 << 8)
 #define AMDGPU_VCN_SW_RING_FLAG         (1 << 9)

@@ -243,6 +244,12 @@ struct amdgpu_vcn {
                 int inst_idx, struct dpg_pause_state *new_state);
 };

+struct amdgpu_fw_shared_rb_ptrs_struct {
+       /* to WA DPG R/W ptr issues.*/
+       uint32_t  rptr;
+       uint32_t  wptr;
+};
+
 struct amdgpu_fw_shared_multi_queue {
         uint8_t decode_queue_mode;
         uint8_t encode_generalpurpose_queue_mode;
@@ -258,9 +265,12 @@ struct amdgpu_fw_shared_sw_ring {

 struct amdgpu_fw_shared {
         uint32_t present_flag_0;
-       uint8_t pad[53];
+       uint8_t pad[44];
+       struct amdgpu_fw_shared_rb_ptrs_struct rb;
+       uint8_t power;
         struct amdgpu_fw_shared_multi_queue multi_queue;
         struct amdgpu_fw_shared_sw_ring sw_ring;
+       uint8_t padding[13];
 } __attribute__((__packed__));

 struct amdgpu_vcn_decode_buffer {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index def583916294..b61d1ba1aa9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -238,7 +238,8 @@ static int vcn_v3_0_sw_init(void *handle)

                 fw_shared =3D adev->vcn.inst[i].fw_shared_cpu_addr;
                 fw_shared->present_flag_0 |=3D cpu_to_le32(AMDGPU_VCN_SW_R=
ING_FLAG) |
-                                            cpu_to_le32(AMDGPU_VCN_MULTI_Q=
UEUE_FLAG);
+                                            cpu_to_le32(AMDGPU_VCN_MULTI_Q=
UEUE_FLAG) |
+                                            cpu_to_le32(AMDGPU_VCN_FW_SHAR=
ED_FLAG_0_RB);
                 fw_shared->sw_ring.is_enabled =3D cpu_to_le32(DEC_SW_RING_=
ENABLED);
         }

@@ -1074,7 +1075,13 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_dev=
ice *adev, int inst_idx, boo
         WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
                 lower_32_bits(ring->wptr));

+       /* Reset FW shared memory RBC WPTR/RPTR */
+       fw_shared->rb.rptr =3D 0;
+       fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
+
+       /*resetting done, fw can check RB ring */
         fw_shared->multi_queue.decode_queue_mode &=3D cpu_to_le32(~FW_QUEU=
E_RING_RESET);
+
         /* Unstall DPG */
         WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
                 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -1239,9 +1246,11 @@ static int vcn_v3_0_start(struct amdgpu_device *adev=
)
                 /* Initialize the ring buffer's read and write pointers */
                 WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);

+               WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
                 ring->wptr =3D RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
                 WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
                         lower_32_bits(ring->wptr));
+               fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
                 fw_shared->multi_queue.decode_queue_mode &=3D cpu_to_le32(=
~FW_QUEUE_RING_RESET);

                 fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
=3D cpu_to_le32(FW_QUEUE_RING_RESET);
@@ -1662,6 +1671,10 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_dev=
ice *adev,
                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2=
, lower_32_bits(ring->wptr));
                                 fw_shared->multi_queue.encode_lowlatency_q=
ueue_mode &=3D cpu_to_le32(~FW_QUEUE_RING_RESET);

+                               /* restore wptr/rptr with pointers saved in=
 FW shared memory*/
+                               WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RP=
TR, fw_shared->rb.rptr);
+                               WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WP=
TR, fw_shared->rb.wptr);
+
                                 /* Unstall DPG */
                                 WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, m=
mUVD_POWER_STATUS),
                                         0, ~UVD_POWER_STATUS__STALL_DPG_PO=
WER_UP_MASK);
@@ -1721,6 +1734,15 @@ static uint64_t vcn_v3_0_dec_ring_get_wptr(struct am=
dgpu_ring *ring)
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 {
         struct amdgpu_device *adev =3D ring->adev;
+       volatile struct amdgpu_fw_shared *fw_shared;
+
+       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+               /*whenever update RBC_RB_WPTR, we save the wptr in shared r=
b.wptr and scratch2 */
+               fw_shared =3D adev->vcn.inst[ring->me].fw_shared_cpu_addr;
+               fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
+               WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
+                       lower_32_bits(ring->wptr));
+       }

         if (ring->use_doorbell) {
                 adev->wb.wb[ring->wptr_offs] =3D lower_32_bits(ring->wptr)=
;
--
2.25.1


--_000_DM6PR12MB3433F0538D298A0069DE0D97FD859DM6PR12MB3433namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ping. <br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiang, Sonny &lt;Sonn=
y.Jiang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 10, 2021 8:31 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for s=
hare memory</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Because of dpg, the rptr/wptr need to be saved on =
fw shared memory,<br>
and restore them back in RBC_RB_RPTR/WPTR in kernel at power up.<br>
<br>
Signed-off-by: Sonny Jiang &lt;sonny.jiang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 12 +++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c&nbsp;&nbsp; | 24 ++++++++++++++=
+++++++++-<br>
&nbsp;2 files changed, 34 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h<br>
index 13aa417f6be7..a19c0c35e2d8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
@@ -155,6 +155,7 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (0)<br>
&nbsp;<br>
+#define AMDGPU_VCN_FW_SHARED_FLAG_0_RB (1 &lt;&lt; 6)<br>
&nbsp;#define AMDGPU_VCN_MULTI_QUEUE_FLAG&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&l=
t; 8)<br>
&nbsp;#define AMDGPU_VCN_SW_RING_FLAG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (1 &lt;&lt; 9)<br>
&nbsp;<br>
@@ -243,6 +244,12 @@ struct amdgpu_vcn {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int inst_idx, struct dpg_pause_state *new_state);<br>
&nbsp;};<br>
&nbsp;<br>
+struct amdgpu_fw_shared_rb_ptrs_struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to WA DPG R/W ptr issues.*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; rptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; wptr;<br>
+};<br>
+<br>
&nbsp;struct amdgpu_fw_shared_multi_queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t decode_queue_mode;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t encode_generalpurp=
ose_queue_mode;<br>
@@ -258,9 +265,12 @@ struct amdgpu_fw_shared_sw_ring {<br>
&nbsp;<br>
&nbsp;struct amdgpu_fw_shared {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t present_flag_0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pad[53];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pad[44];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fw_shared_rb_ptrs_struc=
t rb;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t power;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fw_shared_mu=
lti_queue multi_queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fw_shared_sw=
_ring sw_ring;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t padding[13];<br>
&nbsp;} __attribute__((__packed__));<br>
&nbsp;<br>
&nbsp;struct amdgpu_vcn_decode_buffer {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index def583916294..b61d1ba1aa9d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -238,7 +238,8 @@ static int vcn_v3_0_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared =3D adev-&gt;vcn.inst[i].fw_shared_cpu_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;present_flag_0 |=3D cpu_to_le32(AMDGPU_=
VCN_SW_RING_FLAG) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG)=
 |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_=
RB);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;sw_ring.is_enabled =3D cpu_to_le32(DEC_=
SW_RING_ENABLED);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1074,7 +1075,13 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_dev=
ice *adev, int inst_idx, boo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, inst_idx=
, mmUVD_RBC_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lower_32_bits(ring-&gt;wptr));<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset FW shared memory RBC WPTR/RP=
TR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;rb.rptr =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;rb.wptr =3D lower_32_bi=
ts(ring-&gt;wptr);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*resetting done, fw can check RB rin=
g */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.=
decode_queue_mode &amp;=3D cpu_to_le32(~FW_QUEUE_RING_RESET);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Unstall DPG */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(SOC15_REG_OFFSET(=
VCN, inst_idx, mmUVD_POWER_STATUS),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);<br>
@@ -1239,9 +1246,11 @@ static int vcn_v3_0_start(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Initialize the ring buffer's read and write pointe=
rs */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =3D RREG32_SOC15(VCN, i, mmUVD_RBC_RB_R=
PTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower=
_32_bits(ring-&gt;wptr));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_shared-&gt;rb.wptr =3D lower_32_bits(ring-&gt;wptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.decode_queue_mode &amp;=3D =
cpu_to_le32(~FW_QUEUE_RING_RESET);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.encode_generalpurpose_queue=
_mode |=3D cpu_to_le32(FW_QUEUE_RING_RESET);<br>
@@ -1662,6 +1671,10 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, inst_idx, mmUV=
D_RB_WPTR2, lower_32_bits(ring-&gt;wptr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.encode=
_lowlatency_queue_mode &amp;=3D cpu_to_le32(~FW_QUEUE_RING_RESET);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* restore wptr/rptr with pointers saved in=
 FW shared memory*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RP=
TR, fw_shared-&gt;rb.rptr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WP=
TR, fw_shared-&gt;rb.wptr);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Unstall DPG */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(SOC15_REG_OFFSET(VCN, i=
nst_idx, mmUVD_POWER_STATUS),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);<br>
@@ -1721,6 +1734,15 @@ static uint64_t vcn_v3_0_dec_ring_get_wptr(struct am=
dgpu_ring *ring)<br>
&nbsp;static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile struct amdgpu_fw_shared *fw_=
shared;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp; AMD_PG_SU=
PPORT_VCN_DPG) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*whenever update RBC_RB_WPTR, we save the wptr in shared rb.wpt=
r and scratch2 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_shared =3D adev-&gt;vcn.inst[ring-&gt;me].fw_shared_cpu_addr;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_shared-&gt;rb.wptr =3D lower_32_bits(ring-&gt;wptr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(VCN, ring-&gt;me, mmUVD_SCRATCH2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(ri=
ng-&gt;wptr));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;use_doorbell)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;wb.wb[ring-&gt;wptr_offs] =3D lower_32_bits(=
ring-&gt;wptr);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB3433F0538D298A0069DE0D97FD859DM6PR12MB3433namp_--

--===============0466987826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0466987826==--
