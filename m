Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E154C5AE59
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 18:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E0110E6A6;
	Wed, 28 May 2025 18:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HVu/LcCx";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6393510E69E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 18:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6u90sBOF4X/nzxJtiTh3oXZdxjjXh1gk3EH6/y/4mYRiSbwkPUM5X0EYlQNyRUGRWSnsN3G/TzXL14mXy7Vmsefznum2gjkMMVk3HAcuiTFglwhXDeUhWVsxYAOKpo5UyuxQJPxzEpU2XGTZO4Rrm6SgwHfu4KwHltgnSOKmyn6NzeqTn5umCR3TSx5RR52rE+0zTzpbMvZTM8YfLo+elz0rSTqVObLVMpz/pbj5FtBsACi1E9YAiIkIp8cql6a6SnbLR7fbONq/Y+lcVec2ALuRJisa7yAu0v94EjA5VDsKirEwwNq2awu5dS7Vrt/RYBQAEc9ZfEUQJh7UKG5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9UqwivRk6aI3eJmc3V58hbrZtLQm+Jyy3WD1orONC8=;
 b=LhftJY6E1ZVX2p4ydLPgPAzeATfMC6cHABvb2uhXm/pJPvVhEzRcS7lkfchM7k7fVTh4/dHp6D/RwVvzfjuA6xdsehWkUd5UxFStpT1fLvrJoGYPmouJ4v71PQMx7f8+0mxacNc7ao9DKI4U7+8/bsBMgOy+4XFvI4mp8HkJD+wfgidgrrq9aXeHM8hKe5s/0pVkwWnvu9KjLCOY0lzG6WioBiXzlUw9W7Dl8Hqi13KJOPZ1UCNz60fyvKZeuDpM/CmSn6BfBOOWQHzE/K3JYAA12LRE3oVNKj2qk39V2qOAeb/zQcgzyBNOcal7O10PEkQIAWIyMNHkirDIrlOtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9UqwivRk6aI3eJmc3V58hbrZtLQm+Jyy3WD1orONC8=;
 b=HVu/LcCxH7HxNDZ6+htmP38S3zWqINDcBe+KF2VvyAXARo5+HbTWrIu4AgXgIu8xg7N92CuqG9wX9j8GxwPY1SnvD+nc5S2Dp84hyF956UcDSAU/CgOcduuqa0/4BqZ7HoJ1hFZ8Pj/4+h9j0fs3KDkRMpeuYn9elT+jAzILp5E=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 28 May
 2025 18:24:10 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%5]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 18:24:10 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix kfd process ref leaking when userptr
 unmapping
Thread-Topic: [PATCH] drm/amdkfd: Fix kfd process ref leaking when userptr
 unmapping
Thread-Index: AQHbzx0POiu4gs0cBEeMffX758w/SrPoXG7g
Date: Wed, 28 May 2025 18:24:09 +0000
Message-ID: <CY8PR12MB7099E100E85B3FD1377E3DC88C67A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250527153517.14533-1-Philip.Yang@amd.com>
In-Reply-To: <20250527153517.14533-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4ac73b3a-bc49-4e90-a806-4525a730fee9;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-28T18:21:38Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS0PR12MB6440:EE_
x-ms-office365-filtering-correlation-id: 6dc44926-1a3e-489d-dde1-08dd9e14d6fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4qq37U/DJyvR31KuKlAFFABsu3z6ER6OA+65RdNyl9XwKVGHMbllAY1nsv4U?=
 =?us-ascii?Q?xA7hpay4Y2EEKoORoafQ3baVG9SovDtU23mL8xdB1bgfykR9S0AISg9sMslM?=
 =?us-ascii?Q?JBbrzljW2lm/ztVDJxBY28rPFsluNi7Juk1FGfHjX7WzYxEP8FA9hdlruvhy?=
 =?us-ascii?Q?ZOyCSmQEdwuavkZW5lbMESHlcSaLVS9UV81bPKJWh1dNm93fxKc8jhZ7mEHw?=
 =?us-ascii?Q?aElrwizETmI4B00d4dyNNuMuF+q4DfTwdM7o1+qBokw/Mm/v8wEUQUJhrEZJ?=
 =?us-ascii?Q?ms7hypVvd0yv9jIi/ZTXMhkO8m5Vg4s8W9dbwHoJFnHWahx2k0bNDVBD7KIs?=
 =?us-ascii?Q?AhBbTH5LZwomEQk5H5QxJ2ZW5Jk3WjcGrB3NmnsUxp3GYQsAhadT7E+4kfqo?=
 =?us-ascii?Q?2r1bOiLA1VSzBF2f4Hz5vEUYgHh3UkYJvUKrFwjGv4rZ3olqbJVXHnDRTt8G?=
 =?us-ascii?Q?Mhm1mFrlhTXponAlxh+CtNlmkvzpwf6rpNLS0OoMTztlLO8rISsYZfD76SZJ?=
 =?us-ascii?Q?6MnlteaGdnAIGjo/Wf3IkxF+eYbXhpT6AyhiRrciKbiF6kKDwfHDBV26yOUK?=
 =?us-ascii?Q?wxmXB9SHB0uyCfa4ai+11Dcp4EDadV84Ch+dOAkdGc5VlTBPQ4rfeT488d9G?=
 =?us-ascii?Q?GsRvwpFQqrsgath4EoXAbNQylT/8ChOon1A11JPtTGmWK+/KhUkNrHLePFNg?=
 =?us-ascii?Q?/ngGh3umDYaL9WFq3hEieki3hBH9c4Wn1Rxu/8y5UvpkeCPHJRQFxBhn4Q/0?=
 =?us-ascii?Q?JAPC5l2eH4KQpJ7LWZQVweTmqueT9/i4mHfM0d++2NNKzXHQof8ZiCaElWd7?=
 =?us-ascii?Q?Q2nhJYQ3fOoqFSPRfh0FK30oJAUWW8dAcS1os5ddc89EO6/IWALUYdH5GgwZ?=
 =?us-ascii?Q?jGFcsidhgH+pOFyvydwk/ks19qQSy3jZ4YnvX+ik+qYuA15qioXTJAZjC6fl?=
 =?us-ascii?Q?Ae3RxQBkDYRnRpGKA+H/RuzYBnRSd0VdioJm30Y6FLw+vHTSHcWoRX8kVJuZ?=
 =?us-ascii?Q?ybSLBGjsvdhGOfhkZJc9efNaoTRkDB3ryMAGzhijUaqo++hJdZJjG+MBFBmw?=
 =?us-ascii?Q?5iBKkb/OcR28pkhcarf7fFVJdKbJTSfgLJo2ZxafO1dFzfGhG+Yxog0KWllW?=
 =?us-ascii?Q?uIPY9UgFFS8dtSTMIZmQVQ+9vBeV+IHxJvgNjBfKxIWCg88Wrp+FVJuVbBhG?=
 =?us-ascii?Q?ppmfdV72JxW6EhfBMdYKktddDmFJu57raTEralM+mmWAGQUtjEQXTAAulF3O?=
 =?us-ascii?Q?n0MUbuKRU+me+lRddrVyKj7T7JEq/5SBmANFSNgChUZYNS/Uqf6FwbU6quIr?=
 =?us-ascii?Q?2EAW8EmlPdXF1ilFklMo9yEWMrm28yIh7NnxWfiKHRQsXuxri4LJZLlM+Tb9?=
 =?us-ascii?Q?6YEHopKYB29BBN88/o3d57IKsnqrDfdmPf5tZw1XnhWZKLDFJaKCLKSlTPb4?=
 =?us-ascii?Q?17RNdO0nrAiRPlDR/nSArTHcMHigrTq9YlVqGVJpXEQojMSk8nz/2Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WH1oQxTrY/8pbmiTOxyQ5riAFhriVquNBI225aMdzFHPzLfoTUwhx90CjEEo?=
 =?us-ascii?Q?b6g/BtWM7zzersUz/jaH0lZnhBqmHy6vHaJ4RuWZfY+s+VKohp4fnDi776OF?=
 =?us-ascii?Q?BhBw5ZOv7C432SbFi0k0cyqZLR7bEblzzwuI1MhQCsuOBOp+HrHlOQYh4v81?=
 =?us-ascii?Q?QhkjTeJG+A2yJTjvudKx+SGvsePVBUOC4/eptR82NK38rgr3GtIfP2oYV4Y+?=
 =?us-ascii?Q?hTProPwORYeECPMgK+pyZ1BtdbpaNz4Ao39mtRVpPreBnQRM/27l+h0/WYTZ?=
 =?us-ascii?Q?KkMc3AE0M0d7EtfSYuLMD3RERT+JeneygP5P4JhQOCFqaH5nJf+rodrUL8P8?=
 =?us-ascii?Q?w/v4E3dZNVQrh6D3p/3p3x5x1/3irlWO/J9NclxhB3zflFWwY4PdqgQFY56M?=
 =?us-ascii?Q?kz5Ou1X/BV02+yjMyuZT19m5qB84Nxqtg1OnvFa0ddmwTcQSBHK1LSdYl185?=
 =?us-ascii?Q?pjV3PWmdVIXc9LPNnRNs0xY9qddDebV731euajkkgND3+zwTh937STznGXKy?=
 =?us-ascii?Q?koNpZ5QdeJfo7niNo+xw16cIgcA/NSNXLSI1bSIomaOzBey/CpmS1Ad0kJEw?=
 =?us-ascii?Q?C16BFFl6QV6tb3XSteQYkK5teYEGY2JXcPhSREirri8bxguoFBpSM6OwXUcn?=
 =?us-ascii?Q?OmijKHeV4gmt/HcJELeyb8J+e/M07PFqJsBJm/tHb4C/5NkHhRkJBMd5QnRx?=
 =?us-ascii?Q?u6mXINbTP2iczkEKjmFOJgUcDdCrjGDgO+jocDcQBAm0rtLqbRg2x4eDoT57?=
 =?us-ascii?Q?hUwqyS35f9fxnPSYZ1ZLjocZTAfaAjrCycR8mpe9YzlMPnKUWJVbJ7t+zOjO?=
 =?us-ascii?Q?JibzpEsClt9P8xb8LZB0Gv/hN9o5u9VEXdQJTa7npDbUCYgRci8xDbHFNLn6?=
 =?us-ascii?Q?WetXus6lIHQnSUoAw+JPg6obVWrnYkaj3NG8G+uJwcc2uiitEOPq6MCrgGn3?=
 =?us-ascii?Q?w5YdxhULieixMYzVUsiFzl3FI5Nqu6jx7KeqOlmUL0+b3dmUzm/5cjVuCrvj?=
 =?us-ascii?Q?s8m8xBTl0CnNrp9j2t7jC3af5eZ9qAvOFCYD7BwMry0k/eZMNwrsNtFs2iZc?=
 =?us-ascii?Q?qhWH/kD9GG1oei4MjMRvYWzC+l/CrKNDUKcxt7dWg43yinMuwm7VGVCFPMfT?=
 =?us-ascii?Q?eEIAhlVq9Mud+8s2u9CV0UnBmk/OJIiKLSwG+zkHmpZPoml+yTK6xWq7Hvwb?=
 =?us-ascii?Q?aRPkZ0DFtSgbX3dD6bgzsvIpW1jOJCzn0Z1IKqq/+25qPXPMRH6LAiJ/eOEM?=
 =?us-ascii?Q?Vt+UQiVYaDz+6wkhPWPsyIi+HaY1sQBxau00S47SybFuzm0tcarB3ISDm4lV?=
 =?us-ascii?Q?CztKw8eXAF2veY4tzJKM13D9Ns9t2gO/knnGB4eWb8dT2muJ82gWDqW3bcId?=
 =?us-ascii?Q?ARhCVXE9lWrXNuT075/R9IPCOIFRASTaOfh06AMc8XFBPn4vKQNnzjL/XADH?=
 =?us-ascii?Q?8xM5EQlDZkuu/TdRxArmQsQPg1L24UBECMJ88O9jpPv7nlbaEt20Ux/v0Chs?=
 =?us-ascii?Q?4KeW5hPf/tzp9J8IFNOU+QfBmSWRHdsXknd8D2M4Qhz+B3wH2cjeDo0kwFnl?=
 =?us-ascii?Q?nlfnk4KZJ4/St+I7uZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc44926-1a3e-489d-dde1-08dd9e14d6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 18:24:09.9830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4V+D6FzQZ2VkL1YYwnPDT8WAWWN4kcttmp2saN/Cp77HFb1FlV0648xJQDWYqIKqME2KPqksGTcu004dV/d6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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

[Public]

From the code, it looks like you want to hold reference to the process to e=
nsure that it doesn't get destroyed while sending the fault event to user. =
If that is correct, then your commit message is not reflecting that.

With commit message updated, this patch is Reviewed-by: Harish Kasiviswanat=
han <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Y=
ang
Sent: Tuesday, May 27, 2025 11:35 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; Yang, Philip <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix kfd process ref leaking when userptr unmap=
ping

kfd_lookup_process_by_pid increases process ref, the refcount is
leaking.

Fixes: 7a566d7f56f4 ("amd/amdkfd: Trigger segfault for early userptr unmmap=
ping")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 260165bbe373..99a32bc9bb89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2563,12 +2563,17 @@ static int update_invalid_user_pages(struct amdkfd_=
process_info *process_info,
                         * from the KFD, trigger a segmentation fault in VM=
 debug mode.
                         */
                        if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm_userptr=
) {
+                               struct kfd_process *p;
+
                                pr_err("Pid %d unmapped memory before destr=
oying userptr at GPU addr 0x%llx\n",
                                                                pid_nr(proc=
ess_info->pid), mem->va);

                                // Send GPU VM fault to user space
-                               kfd_signal_vm_fault_event_with_userptr(kfd_=
lookup_process_by_pid(process_info->pid),
-                                                               mem->va);
+                               p =3D kfd_lookup_process_by_pid(process_inf=
o->pid);
+                               if (p) {
+                                       kfd_signal_vm_fault_event_with_user=
ptr(p, mem->va);
+                                       kfd_unref_process(p);
+                               }
                        }

                        ret =3D 0;
--
2.49.0

