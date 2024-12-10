Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A93E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 13:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5F410E8C0;
	Tue, 10 Dec 2024 13:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v8QZj36H";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D2110E5CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 13:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZwpiEJ7LMqvg+9AO9nr2fJ1TZsMy7uQXDpP+QxoyX+iqxNuyUgUhYUsbqlmY06ae3JzFBtXPg999ouyXgGC1agL4XAWG8n0mXgVj8YzMRcwUetFBxHgB5weoSNmD2fvGk+MvGSm78tGJWTZcpQmkgniYb+UQeKTZo//OVvNrDoa7Zzr16WKbWo9CqAgVkdr+DaQnZL2/xm6BEv1lkWVHogOLk3+tFdkxNtSNuNbG3e8b4ZVKZd+JCBxzdBifvljw/GKXDum5tOD/w3dJYMY9m3mldRnlF185PDDjbPpRUxIlKMs+CbrpjGeVy3eZv3+dYKswn2jN5j74Cqn+w8gvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/1mj1A+dvYQQE5nmK8R6+GTquyz2jkvZ3c6TLY/OmE=;
 b=bc08WFe5ua4Pm18wEY+oZ6XESQliOlLxbHxiSz3NgPdX8qEWnmaRhA3yfI88aipQynY55uzorZoUwzfM0xn+4QTCN6psjjT6F94L43kFvXyjUwyM4OP7EVQHb1V4BNv115j38IZJMKyx2mbpusoCc+zsmlY1/en7WVnGmejgfa8TQ52INF4iBq7I7gDmrxUV4AWv53g8lJRJ1OqZ0Dug2k8i0OMYLUQ+nUIf4eoBFroi/WS/oti8aL6C1tPXYkWzCBwnfHLTJo8eIzm5MZ/tQR+3SEeYwKg4uinCe7MqTO66v6dcabEWpwV0t205ljD3tBTxLPR6HyGDgoYsI575mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/1mj1A+dvYQQE5nmK8R6+GTquyz2jkvZ3c6TLY/OmE=;
 b=v8QZj36HZhi8Y1IX0kFj3/6zyzi0QTRDVGwXX81yI6m9dW0qGjagzAGbL5YOl9vtwRTom0RxmaWV7kk58cLJbAlWjvGv/SmYl0zJc1S+f7ecZAqI6VRCptEjd0PFvOr89tE/j1VTkMfu9wlkTUx2oft9tEkb30APNsSI/QOWZMQ=
Received: from SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 10 Dec
 2024 13:04:09 +0000
Received: from SN7PR12MB7787.namprd12.prod.outlook.com
 ([fe80::1d85:6db3:9cd3:51a7]) by SN7PR12MB7787.namprd12.prod.outlook.com
 ([fe80::1d85:6db3:9cd3:51a7%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 13:04:09 +0000
From: "Yao, Yiqing(James)" <YiQing.Yao@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Skvortsov,
 Victor" <Victor.Skvortsov@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Tomasevic, Vojislav" <Vojislav.Tomasevic@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Avoid VF for RAS recovery source check
Thread-Topic: [PATCH] drm/amdgpu: Avoid VF for RAS recovery source check
Thread-Index: AQHbSlKBTcVEf69GAUmw8IWuAmre9bLfcH2L
Date: Tue, 10 Dec 2024 13:04:09 +0000
Message-ID: <SN7PR12MB77874F5A045AF0297F0CDBF2853D2@SN7PR12MB7787.namprd12.prod.outlook.com>
References: <20241209155257.3642960-1-lijo.lazar@amd.com>
In-Reply-To: <20241209155257.3642960-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-10T13:04:11.466Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7787:EE_|DM4PR12MB5890:EE_
x-ms-office365-filtering-correlation-id: 2a4922c2-3fd8-4431-728f-08dd191b22d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?T0XXLWiRdKz2KEir9b3f4JgtHS94kCecfDA6N92n7AZK4/cnRBfKgXm/Vf?=
 =?iso-8859-1?Q?SVXt8qJYhxYnOpNFLwD17Fu0ODLSf+V79XQwPjObKtpFLC1zKhRlwhiSpS?=
 =?iso-8859-1?Q?H0zuG/iqVZAx6ynRqwJHwpT/H/vrojDQWvSJsXm3wOj+XhtgTaMDic4+q8?=
 =?iso-8859-1?Q?R4dtXxtSQ/S48df2yjmuZP4jxfQHK2Wkn1b8O7uGR4WYWBXWV5mWtBxXfy?=
 =?iso-8859-1?Q?cgI+SyEf/xoaxCtodhoJUrxjd7mLUTsC/f0C0cybDvy/Ex4n2Baej9i3ei?=
 =?iso-8859-1?Q?a+NExh52EaOMXiUeHefnJi1TupcEyx35+CdHZ9+RIUqbEVwi9FVBqxOOmr?=
 =?iso-8859-1?Q?UyM0DHWfR704j+63D55Mob8aGEzTkAgR4FwJSn4adQmknqIUHffpBy/vfC?=
 =?iso-8859-1?Q?PcgcCXBUCCGtv20cJZXmoIJBYe6ONfFdvkklwOkl2ejA5i9fn8/j8dHhCk?=
 =?iso-8859-1?Q?GAGIHSyQQ0Gvw0n3xLbIqX8ondKlMkDOHvM8YKs41OLo8fKSI46FpDg/Ju?=
 =?iso-8859-1?Q?w0F6kBxFA4UAhEwf9s9UFDM4WTe2p9JkmdM0SKvt0MdyIv4WtMTGUDBJDf?=
 =?iso-8859-1?Q?SU+er09DPy5mye22SamyYh8zqVJNmyrlSG2oFYpaS42p6AbtzGJvHbPmpf?=
 =?iso-8859-1?Q?xqzO6Ey0iW6Z+Tk9KwUlCUyayM9Vz+K0j9HVMONZuRHNnOXkMPHj4m4p6J?=
 =?iso-8859-1?Q?BKmDDvqg8KUSK9iZqw+zyaP8m50xT+1O73TUVz0pGfPnHpM4dB9RuKWN9V?=
 =?iso-8859-1?Q?qT/LV5IdQOzK56OOZaqd4eClFQgtSzYK62BACBShbyZLbRkrNYtQ4EeM3p?=
 =?iso-8859-1?Q?DmouW0hzFkvxV73pOzaYul0rjgOr7sw56aZb+hiyTDxNtR7dz9bptnNiGJ?=
 =?iso-8859-1?Q?mmoN+SGsoWuQUkMcEqwfh3emiTZbTikAYqihTiSuPcVPhPxj/ptZxz4pGE?=
 =?iso-8859-1?Q?3GRFqJJPKaQbgyoGb0A0z9mUCDLAJmi4SzEBcAA3mpP0wehYuKNqHsvXLN?=
 =?iso-8859-1?Q?ENodCrRu5IhxSXGqCmTxw3IBUYNJiSYNhb2b8SfEjpMdbM0CT778hkIR8L?=
 =?iso-8859-1?Q?H7+SRmgiRH/pM6djBVHxP7nkJR9TGemBAbA8r9wX50BTSM2s3SrHGCGm9B?=
 =?iso-8859-1?Q?tU+X1muqKOTjNaB99m9pp4p/R5QX5XtC4a3v2HotV/eD53b5u0S//g3XvN?=
 =?iso-8859-1?Q?AGtSFjoz0cCweNDPGq5zveOWweqT91oJdFYseb5XH65LRy5Wm4YIN5eB7W?=
 =?iso-8859-1?Q?V7vaM99CVF2VNk2+U+GTXhcEhI42ZfDuF/b03qJ0+Y2U5DYmAvDioAWcqX?=
 =?iso-8859-1?Q?eucpVWaBSLv5A55UexmhiDqXtkDVIf+ANjP9miwzrbg2TGB3dwEnobOCIE?=
 =?iso-8859-1?Q?dPdiLWQy5kxf+WiSeTvFIXEqiTug5jPBNAJF4WwEuTzSsRPH1aE81r9UNO?=
 =?iso-8859-1?Q?2CGmXaXyJu6SCxWIxMUwDxza3nHokgEPzOT1Tg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zdv22iSZw37ezbPhMPuIRB6K9I1o3hN5g/UckLQze6+3MaC9pWPqQgviG/?=
 =?iso-8859-1?Q?cZR6DEnkSHq1kyip3F7xzmvz8Fmam39rHLaFLzd0p3INuei18XGeSsuaSN?=
 =?iso-8859-1?Q?fFHVLhgXO+AswPi9Er31n9c0rrPmauVLWpJ4q17XoQqLCrLiMI96H8B/8C?=
 =?iso-8859-1?Q?aMkKlKkZ6aQrUqnvOAyMMxSm8oZBJWv/qatkl3p0ciqnvDv3TTqc/PBrSk?=
 =?iso-8859-1?Q?2W1Naepv0su2mFG1BvrQb6SsPMFh/IiP4AX+ovKKuTo72WVOizPStxCpRV?=
 =?iso-8859-1?Q?cbXWdruOLOpXa4D1vcdkNbnqIy0Fa7y6P3mvQRWLXhbgJtLOGX0QFuJ9Ps?=
 =?iso-8859-1?Q?lELkeaU53i8XLPYPoyLa9wXIgeNsTxyp6PCa6UcehskSuhjvB+X25lXM9X?=
 =?iso-8859-1?Q?NpRY2/sdraCufs4k0CaZMMaXYhyaofP1Xc9i3c5iulQ+oUjUG6nx0VZely?=
 =?iso-8859-1?Q?j9A9IpyaSPpVX1V0X1ta3G717EuIIRAoY5a6ow5k6vgsUDXAz72bJQSf0w?=
 =?iso-8859-1?Q?drRVpEv+/r9MD4Z4AkgI113VpEcTLapaSi/LEsWsgWCqvppK5mIjvTrUYg?=
 =?iso-8859-1?Q?6tut1/TPkbx7cRqigVi6OvVJXps0VA/GKbZj/tIjhfpEuLqjSltGKtdFIS?=
 =?iso-8859-1?Q?20BiKNsJO5jqkOrVEQYxZTGzCkLJDrTg1V7l9maxLeXa2jupB4m9aO8ZJ4?=
 =?iso-8859-1?Q?jV2mCGwgNBVwf9GQEZP5MIOoH6i0czjuV1kBDclCiMeB6tGESqwI6GPVVZ?=
 =?iso-8859-1?Q?5jTlFi4VZhtnPl+/8agGP62mbx4hKdVBO0g1ebYSoXsLTvyVKvf8jHflvm?=
 =?iso-8859-1?Q?6uWcJuKNIwO24lIVA3VMiikgo8t3sd2HFrig0JkNHmaHzF7ufGoE2lomN0?=
 =?iso-8859-1?Q?gIUNNbZtlbzpRAgBNIGRU5zsY7pbGPBnLuspg56zrCDmkNA87z5K2kF3sb?=
 =?iso-8859-1?Q?d/DPUQXZArp+w3bdIgMQ6gArbeNTrh+uNxVvu9x16uzzCPK5MHTJlWycBf?=
 =?iso-8859-1?Q?zTCumnIl7J+4AnbWLTubDzpLQeyvUHTFnhQnVBQLJCBQRypIZG2vHddx5Z?=
 =?iso-8859-1?Q?G1UYeR4dKP09zBMAXZJkFTH0j3WcYxyL17j6v3uR5LyglU4fYL46dXqIOZ?=
 =?iso-8859-1?Q?+G9l2QMzHQmZUwVucy9gtrYkVQG91BdhVmgC0R3dg3zCmMIaJmMDuY4HyF?=
 =?iso-8859-1?Q?Fnxu4yWSOYae6gbbMhKfekvO+H2UOsLYbrVUnyyjRVpWlk7VLwKIUta1J4?=
 =?iso-8859-1?Q?cmdMbB1MIUB5v42kKh5Qm6RdjbvYlGbfKk3grzLeQCSEMhz2FWnJkd8kOo?=
 =?iso-8859-1?Q?d/QxM8dvsTCbz0vPItv2lccszuNX88bkBS0chQPqTynJBwJ5tKz6c12kFu?=
 =?iso-8859-1?Q?c9XlSVD1S15vB8oveHTKRD6xRaTo8ghxUMxu2IpL/tw44kIB7EemngOXHb?=
 =?iso-8859-1?Q?DIJ0pF+qc6D/FG2gXTI9TdbbAPDkEEOHZNFAbvJBmCkJJP7U6Lkuo6WNBv?=
 =?iso-8859-1?Q?hLOUOVvOXxm4BL+j3mX53wQA8nyXROGFEqoI443N3F9IzvRnLiG4nkgI9z?=
 =?iso-8859-1?Q?Pb/WyZM0++36997Iq68Vjt7kO0oU4LC50FPk3f/PWQBrUudsScyJjwDmtz?=
 =?iso-8859-1?Q?vE4qkX9108Bfo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SN7PR12MB77874F5A045AF0297F0CDBF2853D2SN7PR12MB7787namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4922c2-3fd8-4431-728f-08dd191b22d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 13:04:09.5204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L54qoBvoPPCNC0xl2TOhyOAncOJu5xuxJ/835LXZE/HyzDQ+92Deu6/E4rCT1k5qXGV6Hx6TRNGfu29aOOuhZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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

--_000_SN7PR12MB77874F5A045AF0297F0CDBF2853D2SN7PR12MB7787namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Yiqing Yao <yiqing.yao@amd.com>
Tested-by: Yiqing Yao <yiqing.yao@amd.com>

Thanks,
Yiqing(James).

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Monday, December 9, 2024 11:52 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Skvortsov, Victor <Victor.=
Skvortsov@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Tomasevic, Vojislav=
 <Vojislav.Tomasevic@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid VF for RAS recovery source check

VF device sets the RAS flag when mailbox data can't be read properly.
There is no conclusive way to tell if the real source is RAS error.
Therefore VF schedules a KFD based reset which doesn't set RAS source.
SKip checking RAS source for any VF scheduled recovery.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Vojislav Tomasevic <vojislav.tomasevic@amd.com>

Fixes: 2211660c20a0 ("drm/amdgpu: Prefer RAS recovery for scheduler hang")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 735a01c58cd7..eb3fd55a3702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5864,6 +5864,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
          * detected at the same time, let RAS recovery take care of it.
          */
         if (amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY) &&
+           !amdgpu_sriov_vf(adev) &&
             reset_context->src !=3D AMDGPU_RESET_SRC_RAS) {
                 dev_dbg(adev->dev,
                         "Gpu recovery from source: %d yielding to RAS erro=
r recovery handling",
--
2.25.1


--_000_SN7PR12MB77874F5A045AF0297F0CDBF2853D2SN7PR12MB7787namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Reviewed-by: Yiqing Yao&nbsp;&lt;yiqing.yao@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Tested-by: Yiqing Yao&nbsp;&lt;yiqing.yao@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Yiqing(James).</div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;amd-gf=
x &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt=
;lijo.lazar@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, December 9, 2024 11:52 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alex=
ander &lt;Alexander.Deucher@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&g=
t;; Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Zhao, Victor &lt;Vi=
ctor.Zhao@amd.com&gt;; Tomasevic, Vojislav &lt;Vojislav.Tomasevic@amd.com&g=
t;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdgpu: Avoid VF for RAS recovery source c=
heck</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">VF device sets the RAS flag when mailbox da=
ta can't be read properly.<br>
There is no conclusive way to tell if the real source is RAS error.<br>
Therefore VF schedules a KFD based reset which doesn't set RAS source.<br>
SKip checking RAS source for any VF scheduled recovery.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
Reported-by: Vojislav Tomasevic &lt;vojislav.tomasevic@amd.com&gt;<br>
<br>
Fixes: 2211660c20a0 (&quot;drm/amdgpu: Prefer RAS recovery for scheduler ha=
ng&quot;)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 735a01c58cd7..eb3fd55a3702 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5864,6 +5864,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * detected at the sa=
me time, let RAS recovery take care of it.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_err_stat=
e(adev, AMDGPU_RAS_BLOCK__ANY) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_sriov=
_vf(adev) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
set_context-&gt;src !=3D AMDGPU_RESET_SRC_RAS) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Gpu recovery from source: %d yielding to RAS error recovery handling&quot;=
,<br>
--<br>
2.25.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_SN7PR12MB77874F5A045AF0297F0CDBF2853D2SN7PR12MB7787namp_--
