Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6D4C5DF74
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 02:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3C310E495;
	Tue, 18 Aug 2026 02:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MgbZQJI/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A9F10E495
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 02:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I12enphLU5s+zky1amADl4pyZOysNejhrUbdSO5/LUCO3x1es7TBkGqwHL+YFCS8Jd1f47yJ+hx93C9WUNceGDkwg9aJNv6zIxJj1wRG4QYlorLZnMcXRjLdNhjmsodqXoegbwZAYZ0HAxhZ8ToQpeSUN28Mm4WHj9Fsvclbp+Y6bAosfMXFy9Rlag55xny9pCvrLhPkixtLCLHj7A8khObSncqqqCDV520X+R9xhYcYAIR9E5MncmqtEi2z5dBo1SmhKuza8zmYoZrPwPXDwi2Xd3OkejCoetRL/jW4LGyYN5qTrVhcgGd0bi/yv6Xu/as09QCEQowtn95E2MtS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI/1vjheeGcptxaKD/t6LbVpagJcVF7LNoifyoswLjw=;
 b=GI4oFJDR5dX87BQEfgTEw37m382n8Bu2/w4aHFt5ejddNNHguOGBs7MVj0TRXh1iFIflai9eaAUl6RMnmRHa0NhWCmdz+r35s0IVahXdQpe/lqp7AOtjOX0B3HbCVkFGfYS1WOXzIOC8or7EGCupARrc81L67kVntHmmDVogOEdjEgMx+YxtSMipKYY60hE6mNEoqB0fxr/B3D1oIObMfwQ0t5JnpicA7cdlJ6OBNlENAvYb/aKi7C3IXVP2nRDDcWl7oJJnNfjYzUw+2HvaGK6OpOD0tAeDwrjk4M2qbkLZIuawJKl1xJlD3kFDQ8tJ1Dhv1H69OFZRtHlR8sAxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI/1vjheeGcptxaKD/t6LbVpagJcVF7LNoifyoswLjw=;
 b=MgbZQJI/DjXpqaKPXgesYReKoo+m+nxGpl3SKL2dksFuQ4vzSBveCIPR2ysjpcfjurOY3D3TgaZyBlSF5XVt8HOpd0WJ5zgc1lZF5wVNLCvdNhbA24USBGL3GnNGx6pfXDvcnOXNIj7Q7m9nBku0NZ86XPB3coeT7hkL9SWhoCU=
Received: from MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 02:50:33 +0000
Received: from MN6PR12MB8590.namprd12.prod.outlook.com
 ([fe80::ac74:86e4:cd33:432f]) by MN6PR12MB8590.namprd12.prod.outlook.com
 ([fe80::ac74:86e4:cd33:432f%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 02:50:33 +0000
From: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
To: "Belanger, David" <David.Belanger@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH] drm/kfd: Add CU occupancy support to GFX12.1
Thread-Topic: [PATCH] drm/kfd: Add CU occupancy support to GFX12.1
Thread-Index: AQHdLpJTBkjOsYDJKEO+S+dX4+175LajGyzQ
Date: Tue, 18 Aug 2026 02:50:33 +0000
Message-ID: <MN6PR12MB8590CC24098118FF3C86E75CFBA62@MN6PR12MB8590.namprd12.prod.outlook.com>
References: <20260817214908.99287-1-david.belanger@amd.com>
In-Reply-To: <20260817214908.99287-1-david.belanger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-18T02:49:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8590:EE_|DS0PR12MB7770:EE_
x-ms-office365-filtering-correlation-id: 21fa3183-7548-4d1a-97da-08defcd3793b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: KSnq+kVAe0n0COoM794OzQT3FJTIabBTxKsPSJlvXbSm0eVmETKrn6acpOBX94SvJSmakj9PHszyNU36rjPr4blq34v6MX0txhOpC9kPDxIJilwRmKqTm85wSE9ilh4tFOx/bt6XYYec30k9SHBzZFpWBeAvSPl1Ku8Jb5eUeZYo8rBFMkQbH9hxb/F5+ttfroOXYgMJSVHzTBx+TJ6Dq8CckEnfCxfut5MaCgKHcBBhLn3/i1+9eYOIPmY2fbU5n3Ofye63JavEYuAcbNbL5eGCGa8hgwy07JcLfd3dBRYg0mgyIniG5I6ionLgRPlX9aR2rtuEWfudEiiSyJgYty3cGaaVURC1yL93rAs58t/7oSi/sglT9LjZtIIlfbo1e9pISZ0VlJT6PfHuocP7bqWUdIckArzpZqOakCUNzWLoCP0CGm5c73pL0brFarROBSTRumdDADVmhCYGHiDvBx4nm8fVSY15A8/fyTkv9Oo+3ZzmYgbQV3yS70QxHmlSdmZc38HUCTQhf5hXkbwSeFjC+tmUbJQZQVbMBjwditgV1Is8fiN1xKJ58zRoR/x8+VA/t5dLCempOuO6+l1Kvrzg/oF+K/YRGRzdKz3T2rmq6TCtySjQDayjlxN2YV49qOQB4bl0FOfqYSHeNkWZR0pWlZlM8ITIL8+AuKtZqhZ9B5uuDgv6Y3mxE7H1Oxu3wnaky6OrbiJs4uJ0BgVhS5Ehb0iIWOPoS4nNx08eJJk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8590.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+myWGRqm/NZ8tkN7CZJG+swCsbdgpp2xsXJW9Fm+nVIHKmVjHK+9gS0xeBya?=
 =?us-ascii?Q?EHyffAizjCbB+8jYYPsy73yVyFUPho86vqm/q1xxsTST6e+vGv3WMaajPyY0?=
 =?us-ascii?Q?GGnaYLWxQnMx1SOabgN061uc3bOFSAn7rWOqJPDc8d2ESgv8c3KBrwbgXDkM?=
 =?us-ascii?Q?yT2IbAZT0r68exSZ50zpMJcIHF5AvkiqPKFcDd2FIzSZp93YxqxfrSQVg/Pa?=
 =?us-ascii?Q?BV838jCNu1j3rPMvUZ0PhDxsjrUgb59PhOi2VtbogYzntJublwdUUNxlkunp?=
 =?us-ascii?Q?f/PpEjmQqKn3IXAMByQtKPjsn2ZDcTE4eVbdnn7TAYbMiKjvpM5hcIjV2dEZ?=
 =?us-ascii?Q?i7yyZPQZRj5Z4+a3Qwd30qYQruB+gQ2vE8cBWMk7jrBmlMkXKDm1j2WiQcZP?=
 =?us-ascii?Q?EZ1GA9O+A06MCX8HWOmDkDq9C1ked5mawJeT5c0qIGLB+2GKEpwuXQejkY9+?=
 =?us-ascii?Q?0DwmX9jG/YQ9OO8iOAJrsxUaoAAx9cVX8aoA+oT8tKYZgCz3x3/iEjriJBhH?=
 =?us-ascii?Q?CdzzhSkreULL0HCNxrnd62GgljI/HBS0aeWJRbnzF+falv1wkeSrnlYR+4p9?=
 =?us-ascii?Q?xu1gkhTJK4gMUwWkRGUKS5rMX+w0/8PzF6BakxC1uUcfsByDRFO++DGJiy2j?=
 =?us-ascii?Q?w7auSaNyKR2nUwalwGeHqid92fX9yDuHrT3o3QICBN5SSzGazOHCR4uM7SF0?=
 =?us-ascii?Q?eC/XflG5PY7colsxNrmpifXS+fM06BrPwQMRb14vZKTEpVR6rR61v716xXPm?=
 =?us-ascii?Q?IxXVxOHgZQUwFUQirYyMoT9xhQtI/MCGB/50qzT+1XBEfFWO5LDdeJLiEO8v?=
 =?us-ascii?Q?ThywkEKs1mSbfFqAqI57Gj4TxgypmRtnGbdCKr7JD30C9xI4IUviFCClVBe+?=
 =?us-ascii?Q?3z75gBWoXbmUGRBht6WPHOzE7uWnrTfzYR1iB6Arnrdxn9hvdZcB33OjhByE?=
 =?us-ascii?Q?5hIuAZ2DL35itAfoCi3pdUlf5n1a7Bc3xhwCD5/yjX3n2fjRR4aUpZeLRxmm?=
 =?us-ascii?Q?6p0ygJo3Zjq2TUpEuCzQcBxdP+LIG3F242twx9TufJEF99ryX6ElUn7y4Y5A?=
 =?us-ascii?Q?O/mfnkPDjOUkTPsS9h6yndiAX1HwjgA6++udtiYNZqN62gv8v1oUIetd4nzq?=
 =?us-ascii?Q?RtbkaM0j+bO4231FB50Ys+MygkwWzRlsRTTTmzrz+5XKBadT69/1HTLM2yX3?=
 =?us-ascii?Q?ZRvBqzVI+AdmjUHxstPBLihmNI7f0CWbT/Xlrsln52bdFuNgzLnBVHUtsTiS?=
 =?us-ascii?Q?zFtNqS1tqsTxTmHtAnn4gXA0YCD3bwSVtml9BgAqD7jiD8sT4uNF+DQbqYIL?=
 =?us-ascii?Q?rWTcKi+y/XqHnvBM3Q+6nkiQNoFx5+kUHeq5ebeVMOb+Y+DIObn+BGVB1/oh?=
 =?us-ascii?Q?+u/D6E1bhnuzI/QH4npogp9Jz+ruCZJKiD/q8pZNNqvyav0g1Pk5C4rffUvO?=
 =?us-ascii?Q?e2aP5DS3qImvmkIBORfJwWihV/YlMuKzfEvi+fCpfqqFNQwfmcPcUdRlAput?=
 =?us-ascii?Q?/KHAIu18YYyT23i0eRqWQZpuB3AY4KbqHo8bk+hWNrhzMs3wICSTjtuGrgns?=
 =?us-ascii?Q?oM/Pe60DsOQf9Bwk65LwXLy6fP1QsmufoUGDlApTv3EYfXIf2cYUAabpVMLh?=
 =?us-ascii?Q?nM3ylYXtjwVOdMD+3qa07fVu+1L7hAKzVamfNZ6+Pxl7WymuSy82h1XU1wba?=
 =?us-ascii?Q?scFWwOpu78vgYB8XWxQ5khQECBn4WVD5lPug5kONlyL0NY7e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8590.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fa3183-7548-4d1a-97da-08defcd3793b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 02:50:33.5005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvt5FhPpr9vh1uT/97sOuNazXE85XJlmoR1Uao2jUJ3y0PJf/q7MaFzG2xY1JxcqE3W3Z1qmjaoVqiq24kkvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
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

AMD General

The only nitpicks are stale GFX9 carryover comments (VMID vs. doorbell). Wi=
th those addressed, this patch is

Reviewed-by: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>

Regards,

-Sreekant


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Be=
langer
Sent: August 17, 2026 5:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Belanger, David <David.Belanger@amd.com>
Subject: [PATCH] drm/kfd: Add CU occupancy support to GFX12.1

Port changes from GFX9 to GFX12.1 mostly as-is.
Minor changes to register access code.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: David Belanger <david.belanger@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c  | 150 +++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index 38ca1aea33b2f..b9a4a365e58ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -371,6 +371,153 @@ static uint32_t kgd_gfx_v12_1_hqd_sdma_get_doorbell(s=
truct amdgpu_device *adev,
        return 0;
 }

+static void lock_spi_csq_mutexes(struct amdgpu_device *adev) {
+       mutex_lock(&adev->srbm_mutex);
+       mutex_lock(&adev->grbm_idx_mutex);
+
+}
+
+static void unlock_spi_csq_mutexes(struct amdgpu_device *adev) {
+       mutex_unlock(&adev->grbm_idx_mutex);
+       mutex_unlock(&adev->srbm_mutex);
+}
+
+/**
+ * get_wave_count: Read device registers to get number of waves in
+flight for
+ * a particular queue. The method also returns the doorbell offset
+associated
+ * with the queue.
+ *
+ * @adev: Handle of device whose registers are to be read
+ * @queue_idx: Index of queue in the queue-map bit-field
+ * @queue_cnt: Stores the wave count and doorbell offset for an active
+queue
+ * @inst: xcc's instance number on a multi-XCC setup  */ static void
+get_wave_count(struct amdgpu_device *adev, int queue_idx,
+               struct kfd_cu_occupancy *queue_cnt, uint32_t inst) {
+       int pipe_idx;
+       int queue_slot;
+       unsigned int reg_val;
+       unsigned int wave_cnt;
+       /*
+        * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
+        * parameters to read out waves in flight. Get VMID if there are
+        * non-zero waves in flight.
+        */
+       pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
+       queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
+       amdgpu_gfx_select_me_pipe_q(adev, 1, pipe_idx, queue_slot, 0, inst)=
;
+       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC, i=
nst),
+                                 regSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slo=
t);
+       wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+       if (wave_cnt !=3D 0) {
+               queue_cnt->wave_cnt +=3D wave_cnt;
+               queue_cnt->doorbell_off =3D
+                       (RREG32_SOC15(GC, GET_INST(GC, inst), regCP_HQD_PQ_=
DOORBELL_CONTROL) &
+                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) =
>>
+                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT=
;
+       }
+}
+
+/**
+ * kgd_gfx_v12_1_get_cu_occupancy: Reads relevant registers associated
+with
+ * each shader engine and aggregates the number of waves that are in
+flight
+ * for the process whose pasid is provided as a parameter. The process
+could
+ * have ZERO or more queues running and submitting waves to compute units.
+ *
+ * @adev: Handle of device from which to get number of waves in flight
+ * @cu_occupancy: Array that gets filled with wave_cnt and doorbell offset
+ *               for comparison later.
+ * @max_waves_per_cu: Output parameter updated with maximum number of wave=
s
+ *                    possible per Compute Unit
+ * @inst: xcc's instance number on a multi-XCC setup
+ *
+ * Note: It's possible that the device has too many queues
+(oversubscription)
+ * in which case a VMID could be remapped to a different PASID. This
+could lead
+ * to an inaccurate wave count. Following is a high-level sequence:
+ *    Time T1: vmid =3D getVmid(); vmid is associated with Pasid P1
+ *    Time T2: passId =3D getPasId(vmid); vmid is associated with Pasid P2
+ * In the sequence above wave count obtained from time T1 will be
+incorrectly
+ * lost or added to total wave count.
+ *
+ * The registers that provide the waves in flight are:
+ *
+ *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is
+ON if a
+ *  queue is slotted, OFF if there is no queue. A process could have
+ZERO or
+ *  more queues slotted and submitting waves to be run on compute
+units. Even
+ *  when there is a queue it is possible there could be zero wave
+fronts, this
+ *  can happen when queue is waiting on top-of-pipe events - e.g.
+waitRegMem
+ *  command
+ *
+ *  For each bit that is ON from above:
+ *
+ *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides t=
he
+ *    number of waves that are in flight for the queue at specified index.=
 The
+ *    index ranges from 0 to 7.
+ *
+ *    If non-zero waves are in flight, store the corresponding doorbell of=
fset
+ *    of the queue, along with the wave count.
+ *
+ *    Determine if the queue belongs to the process by comparing the doorb=
ell
+ *    offset against the process's queues. If it matches, aggregate the wa=
ve
+ *    count for the process.
+ *
+ *  Reading registers referenced above involves programming GRBM
+appropriately  */ static void kgd_gfx_v12_1_get_cu_occupancy(struct
+amdgpu_device *adev,
+                               struct kfd_cu_occupancy *cu_occupancy,
+                               int *max_waves_per_cu, uint32_t inst) {
+       int qidx;
+       int se_idx;
+       int se_cnt;
+       int queue_map;
+       int max_queue_cnt;
+       DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
+
+       lock_spi_csq_mutexes(adev);
+       amdgpu_gfx_select_me_pipe_q(adev, 1, 0, 0, 0, inst);
+
+       /*
+        * Iterate through the shader engines and arrays of the device
+        * to get number of waves in flight
+        */
+       bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bi=
tmap,
+                         AMDGPU_MAX_QUEUES);
+       max_queue_cnt =3D adev->gfx.mec.num_pipe_per_mec *
+                       adev->gfx.mec.num_queue_per_pipe;
+       se_cnt =3D adev->gfx.config.max_shader_engines;
+       for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
+               amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+               queue_map =3D RREG32_SOC15(GC, GET_INST(GC, inst),
+                                        regSPI_CSQ_WF_ACTIVE_STATUS);
+
+               for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
+                       /* Skip queues that are not associated with
+                        * compute functions
+                        */
+                       if (!test_bit(qidx, cp_queue_bitmap))
+                               continue;
+
+                       if (!(queue_map & (1 << qidx)))
+                               continue;
+
+                       /* Get number of waves in flight and aggregate them=
 */
+                       get_wave_count(adev, qidx, &cu_occupancy[qidx], ins=
t);
+               }
+       }
+
+       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, i=
nst);
+       amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, inst);
+       unlock_spi_csq_mutexes(adev);
+
+       /* Update the output parameters and return */
+       *max_waves_per_cu =3D adev->gfx.cu_info.simd_per_cu *
+                               adev->gfx.cu_info.max_waves_per_simd;
+}
+
 const struct kfd2kgd_calls gfx_v12_1_kfd2kgd =3D {
        .init_interrupts =3D init_interrupts_v12_1,
        .hqd_dump =3D hqd_dump_v12_1,
@@ -384,5 +531,6 @@ const struct kfd2kgd_calls gfx_v12_1_kfd2kgd =3D {
        .set_wave_launch_mode =3D kgd_gfx_v12_1_set_wave_launch_mode,
        .set_address_watch =3D kgd_gfx_v12_1_set_address_watch,
        .clear_address_watch =3D kgd_gfx_v12_1_clear_address_watch,
-       .hqd_sdma_get_doorbell =3D kgd_gfx_v12_1_hqd_sdma_get_doorbell
+       .hqd_sdma_get_doorbell =3D kgd_gfx_v12_1_hqd_sdma_get_doorbell,
+       .get_cu_occupancy =3D kgd_gfx_v12_1_get_cu_occupancy
 };
--
2.51.1

