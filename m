Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5D7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Dec 2021 02:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD89F10E135;
	Fri, 31 Dec 2021 02:56:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB79810E135
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Dec 2021 02:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKRluJRUe10eeKbBbWUvBZYHj2RqJVl/hZlqAHAm8wKqGtVl5nJbl+Eb62Y3qR6NVAU3Sj23ObIR6uQI42mt1ZhBjjQn5jNsgF+5JHWwgxRWQE6gKLBz6ev7NYG79IVtXJaDiLyXKd+SHhvllN9SMkOKg46f6dUZwUDR4KLe7C9XtcX9CSM5nXjXzR85qC0WJd2gcZoNtwkGKTg8x/N+429TR2jftRw7doTEPnL/Vg6pAKjYWwOdqyuxnl1XLiaOCCEVb6BsOF5A+38auYLSTAw+T1emYCTvXKx5gwreMWuXfHCUnjUv6akBETUxvtQ5OFECdmRzjSxZV/3GLYGPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74mnV7OFYoCCkx00ja8z+3ZCc9I0vbSsGNe+DolhYWM=;
 b=aBmU/6+3sihOtSrTZETZVc3OWOucZODVgj39l7cAC1oA+oN2MssyLqXlFSb/DkedhR7yG2zCOm1709Xv49G2ebWW1f309FfNKES4GC+EMvCKlkgn1MaP+XMWaKupjT6RSXyC/avSH8JnFpauvbnzoiU9h1VOCEVzYOv+mq3Cjfqs4JTUTZY+kvlbWyI0jCnWLM9Lwk6DZ5zK1LHAqUaXwMrnJChDJY59jFwK5oJdEcfIY1j1JBl7sHHSYY1pR65sbTTsYdtMgUvvGZP/RqfGND6J9LXJUFL1rAkKFV+EMEo+mH/FZiEj8T/aQPdlNb3Utsof5E4LyGvgvac6nePrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74mnV7OFYoCCkx00ja8z+3ZCc9I0vbSsGNe+DolhYWM=;
 b=e5h5mXlYYb6H7rE/WIg3dxGFmIBVD8IMSP9e7zga6z2o7rVJh17ffCZVOhFUdA3ho33jyks+7PbHW/536f1FnZUbfcjMFksPiOVl1QiEGgpQrqBez4H5f5O+pA0gLB9GVyWYumxHXK0qh0vznVBxhTgyMUVdbHTW8v9f+J1Pmm8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 31 Dec 2021 02:56:20 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 02:56:19 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: keep the BACO feature enabled for suspend
Thread-Topic: [PATCH] drm/amd/pm: keep the BACO feature enabled for suspend
Thread-Index: AQHX/WQ4NJYhHLaUSUWAGcvZn39om6xL6PyA
Date: Fri, 31 Dec 2021 02:56:19 +0000
Message-ID: <DM5PR12MB2469DBA3696C9AB8C6ACB8E7F1469@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211230100114.2171135-1-evan.quan@amd.com>
In-Reply-To: <20211230100114.2171135-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-31T02:56:12Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7eda5979-1235-402e-8b7c-611c0442a48c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-31T02:56:17Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 72ee0763-9f76-4fa0-b03e-b021f0a65eb2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 645670cc-3172-4499-e52c-08d9cc091f2a
x-ms-traffictypediagnostic: DM5PR12MB1835:EE_
x-microsoft-antispam-prvs: <DM5PR12MB18355FE3ECD76D735D7F9951F1469@DM5PR12MB1835.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncLC/+xk2Dcymysa1N6DHIHWGPJcvD7IvdCcn3twRjzP2gDoZtdNa3as/8HBxG9aBd0Z03qsP2KhZkYJ6I3OA48uAwXiq9Ty1I5NEXkl8Z0gqsk5prFSXz37OuHnL02FFwYKQsa8aiazqZ/IENi4rj6H/BQQc51XCA9C10qzFVpvTefVpMPuW8N2hfNheyZjHk0cZze5KeRAqamLdcdLQjIijuow7WuNKyxGLsVxbuG95Jwd89VzaMx0aHa5Vypa1a+WPTpgioo7vKy0Lqz/0SQMEjdgyTOuhXNJoeBjC+m8wsxJUQXeP0ee33K2b1Fh7O4u9fmuLDeT2XQMZnEEjEs/X0o+VYt8Sgs+8JNpuqObsXyXCf19elDVODm116eeWplY57NBw1qthKPFsqr+W1s5KFZnBwyEiFlg9YbhS1/F4MjbqM0xVmGd7EgJbA1Gf2K8a9SopemHhQxMLR08hV9SypCQkPzSMC9p2ERTL0D8zMaTVhmb4s8McyT1z9tzXBBkrLBTiwH0bpMzVXqB3BHYX9fhkXE/saW+O9OXTcFrA/uv9p6nOl9reQ63RH0ptROlQQCOtJI5RGWI00uIaXOSbUlvnMee5cRrN0299co+DBDjsS6Id9L/0xtk2FY3UchU9a1yi7vAyCC6wi8tAG7mi8lAP3W5GgVmtdCaRIlEXLBeJWJpkeTnbS87Qx5AvayoRrwoLjhHq74T/mOneg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(110136005)(33656002)(4326008)(316002)(8676002)(5660300002)(52536014)(66946007)(9686003)(122000001)(66476007)(64756008)(66446008)(6506007)(71200400001)(8936002)(508600001)(66556008)(7696005)(55016003)(186003)(38100700002)(2906002)(15650500001)(83380400001)(26005)(38070700005)(86362001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c07u2nTdKuU6bN7LbqHiPu0BhyS+KGWg0O0Sk2Y48lbniLQl28pGT+WMNgDh?=
 =?us-ascii?Q?IGTj+4V1wt8tXkv6w/IUqAjHlWWW6XzsvU5EpRoqZn0yhC31ic7re2oEHOEf?=
 =?us-ascii?Q?iBFzmSYRN1TcEIJBzk0qcvAf3L+7hlozIlc6xLRfKFsZP3koRcwafFqAc3xY?=
 =?us-ascii?Q?6gwX+fh8Ux1jJpmnSGlthQrHFtUaZrusG+Hpd4sr1auswIf2r4MO5YcNYp2F?=
 =?us-ascii?Q?tehQ6aCDSLY+DLlHzwBrCDroXVvWY4XdP2sRWZodwzhJHMYGX3D2MV0aysXD?=
 =?us-ascii?Q?hPvnA5mXHDVTC3NGKATwBK66I+yzBvhNLGR9HdnrLP+FwiYs+R/GnWe5ahDU?=
 =?us-ascii?Q?6NqLcVF91iAgV/acFXBLQ/Iuo6euZG/r+8mRYdNGtYZn7y2lm1l9CbXN+t/L?=
 =?us-ascii?Q?80JLHbS8X/y2ovc6LQnlGgqThiRwlTXA3QX8Vh+M6bx4hE9vd6mJ94O5Ot6H?=
 =?us-ascii?Q?Y6leIIZIakN4YZgtqbozkNmN6NENCbx1w7i3FO6SxCEJAes6Hunu9RBzalQl?=
 =?us-ascii?Q?0D8e4zmtwOvzNqPFgz4rOLtFIT828CD5BX/Oyn5IvVxEE/44glEkqCkkOx1P?=
 =?us-ascii?Q?9UQnbNc14iQ+EZzyyLy1npIDxoXWy6UOKjczA36wIqFpYA41AJPyqI0SjBpQ?=
 =?us-ascii?Q?uZOK3RxRiVah31OZmulH22oJbtLht+MlvJTPXNlIEh+t6FY9zaFewHmsHnHw?=
 =?us-ascii?Q?ZcvHGgw227N+e/Zw9lIaU1WjFgGAfTL1iFfPKFpFL5ghHMc6xPtK7BUTZJbw?=
 =?us-ascii?Q?AftLTPTDrQT8/NNEocgCeMIrqNLtfP0OVXThZOl3G+CvQgs6Wy868ep4NnOf?=
 =?us-ascii?Q?fWhWxXffKGHgvTHEm27lLs2VdfOLfC668fqk9RSISQG+okXeTUuCTfIblUDZ?=
 =?us-ascii?Q?ywyDTHvIT8eLmXfOx7AHvkkBuzCJ/skmTDftAeiPGmqdA1qrSrB698QYNiIP?=
 =?us-ascii?Q?IfwYrdPM/PC+meDVfRbKz39ldxO7WLLMABapyu4PHWg0O7K10DZA+jLNxyQM?=
 =?us-ascii?Q?gJ586WNyox8xMxzkekREv8H7deQD/iJJVBxaoKH31QJkZ0RrVUqNqtHJz4Sm?=
 =?us-ascii?Q?2lX2pGVj7r3N1YtN7DnrREfOaUw35qpvho9ovkQCusxCjS4dlLwFgUSKKyVh?=
 =?us-ascii?Q?fmpcWRxnHsjWXHcJLqWsCtxlkSRXdUYCbRR+0QTsQ1okpT+t8vYLApdKSmic?=
 =?us-ascii?Q?BEcoEnMoO5uB4lhAEWi0OiGmID0yBFi48xKrSQbvS91w+7Lewkfp08rKquOJ?=
 =?us-ascii?Q?ayPmQhzv+oeiO9Vb9k7NIEOONqHWQlmUDGb6yQtBUvicNT1tSybWZQKBq8bJ?=
 =?us-ascii?Q?TbVyejuF3xsNarsAC5Am9S/lhN3I3sOJiNhT/tytax2sTanXnNTuSvnNlJD5?=
 =?us-ascii?Q?bzwXmiWoTfn7KjxVia8f6sXAJq5DIHIYcjekBJcM4xHkB1HeEqnwfcz7mPVW?=
 =?us-ascii?Q?OTJksmDYJWYs0CvIMQ/bURw1OH8HNRGzuBhZsQXrgKlTWyqOWHPLF03hnefJ?=
 =?us-ascii?Q?Q5QvdRNFYcKx8CnWKZhgNBQtvGCeUqJdxvH9440oMTvN6J8/gnyu686oonFA?=
 =?us-ascii?Q?5ZfZw15yMfeIwxCh/gBoIQk2JhTS5o6jaTxWbl06DW43tWZJo16d9C7EtOBD?=
 =?us-ascii?Q?N2EXiaEYU3hgKpI8nvKw3Mo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645670cc-3172-4499-e52c-08d9cc091f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 02:56:19.8531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkpe44D00a34Q8bJs8Gvap5Hhf8P6B2fn74DgwBR5PZq0+M54GehDDey2xIDY6JS90WdL5kh25Ed1BwdUU/DPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Thursday, December 30, 2021 6:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: keep the BACO feature enabled for suspend

To pair with the workaround which always reset the ASIC in suspend.
Otherwise, the reset which relies on BACO will fail.

Fixes: 50583690930d ("drm/amdgpu: always reset the asic in suspend (v2)")

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I39ed072af16e34ef1e1c16b50ace6d46fbc388b9
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 4d867778a65c..7628be2f2301 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1308,10 +1308,16 @@ static int smu_disable_dpms(struct smu_context *smu=
)  {
 	struct amdgpu_device *adev =3D smu->adev;
 	int ret =3D 0;
+	/*
+	 * TODO: (adev->in_suspend && !adev->in_s0ix) is added to pair
+	 * the workaround which always reset the asic in suspend.
+	 * It's likely that workaround will be dropped in the future.
+	 * Then the change here should be dropped together.
+	 */
 	bool use_baco =3D !smu->is_apu &&
 		((amdgpu_in_reset(adev) &&
 		  (amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
+		 ((adev->in_runpm || adev->in_s4 || (adev->in_suspend &&=20
+!adev->in_s0ix)) && amdgpu_asic_supports_baco(adev)));
=20
 	/*
 	 * For custom pptable uploading, skip the DPM features
--
2.29.0
