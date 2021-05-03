Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FD3C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 14:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF4161283
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 14:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF4161283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ACD66E12C;
	Mon,  3 May 2021 14:34:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338D26E12C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 14:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jcj92M8OVhsHAqmFVdqMoMStFULMCB75wIZKKuGJGHw/S7ueKr7XIMFlunXUMHdoHq+dnpawZ96Yj7s8HmqbZuwHzQ43TNp0CXwsY3FjFY9XDlhI6o95/GZWmbZomvDnsEan2n6DOL9WYs5FuehDtxIhkPP4NBNDjxtcRZYdQGeL6V/xlDF5zHkFiqlzXT0yGHUKtqYucrIgQTsk8dy4yAJxiBIZ1UoPYSKk0m1WOzCKDFa7dDhLl5ziM2dDu5QBAQUO1P65BX74l/e9F9ybulNRkd183yZ22fbbJejTM8yvlyK7YDO2U3hxIjUA6y36ZjuPGx3eoV7EYrcAbQ+onQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnoVunObGwgZw6v7zqos/6AUbh1kNaAzJNkJ7GduEys=;
 b=CnavEsqkOowj6lvT25t3en2BwqbfdmV1uY2gkGFC3TUbgB+6AgH5hxiaXg+w+VjFYRHqttFdGn1yEmxQIaXXS38axk6mHmkjbY+6CezDI6GYSL7TulD4c5lAg3ti55OAsLhdYSqDR1clKnsRBFuvc15VfemM1O7a3vFBYAj/CnGJJFClYrL45RC+fM1wZnSK83G6EJRGAXJyEXlpHBnsAeQdBnu8QcgLLbbkQk7uaNRqdF5Sld2ka20h5ppzHVJ3VUIwdVInn63H81pKhSqLg00/3aciigxrmkXSduTrTIwoHBy5xEv6Q9AYrXt9n7bPsRByCf1I0UShjhzDTdgTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnoVunObGwgZw6v7zqos/6AUbh1kNaAzJNkJ7GduEys=;
 b=sjm4tb5XhaRnG/7M4gvgJBHah8bdRMS6G4Jeg7IB4ZmRtj3q5ZtlMl/BAKB/HB7Eb0edzzcHtiCz/199QXXuCo+rROvc8Iwa7nbZ59D/RwYKAn4+SfoI/lBy6PFyady9flL4VK/5irbu0gvh9vPqyGdhOnp6xvP48hnXvU/GnNg=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Mon, 3 May
 2021 14:34:42 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 14:34:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private buffer
Thread-Topic: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private
 buffer
Thread-Index: Adcyd8YK4pp00ZyLQcGIGtNhxLg8mANa3k8QABGJPlA=
Date: Mon, 3 May 2021 14:34:41 +0000
Message-ID: <BN9PR12MB5368459A9811D287C8149C6FFC5B9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <MN2PR12MB45494ADEDB34EB9E565D0CC9974C9@MN2PR12MB4549.namprd12.prod.outlook.com>
 <MN2PR12MB454958A234C834277F0BF5FC975B9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB454958A234C834277F0BF5FC975B9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-03T14:34:39Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8655b2aa-9650-4dfd-a884-bd1b3ec4e5e6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2181442-1852-45ef-9928-08d90e4096c2
x-ms-traffictypediagnostic: BN9PR12MB5273:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB52732210893DBF53D9DDD43EFC5B9@BN9PR12MB5273.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaLunluFU8HDLDinxwTp7CfP7mmokg64MyDvCk/UVEt2q97oi7kIXQHPpb2CUuQd3k/dbncwIy28GtRBRjDA0VQurRpmFLwvAX7aM2CagOmFGjBaRI0DX8Rs2/5ss4JxkJZb3/kpDi8udd/w3sX+ZDdnVvdLaE1292IinC7fMdhZg3tZKKq/VdGWA24bn1TdWN8gur+gpw66DdfcDVCeeESIlPKTg1bDqgBCMfCIJ0T8GAZen4ROtNJ5Qa2c/se8MiWn0o4PduUx46q7WtGUadCoONhNJ+oV+cgHIKtGm0LgLdayfD1G7mCqox475K4R/Ro6nEKS8+QZSaoepBS44RcMiCDr2MROi8hEuVVSJ2p08MwWomI8UJguW64T1hdHxuCDUMSkKl0CUqowmsQScY2hOr3TRCLNwjEwV6R4HiugIVmYxP9hScwVCHeYMgi4xbJVyTb5o4gnfhqGPLvWD/KIoLDJN2vjbsiMUNUip2FFYMVS5QVE2VhGrPXfHNWzbopAjZSOIG72itKrlWg3pBy9K61oi9FPPYH+abZKzjBfgWSYbUG3SY5V723D0uiTD7BhbexCRXrjD+7HOEatLgB5ADhxHAvToGEsprlP6BPhUTMRmyhfO9nbU4M79eWH9/cnuk+26npfk57Tr9T3aQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(966005)(478600001)(55016002)(71200400001)(26005)(186003)(2906002)(4326008)(52536014)(5660300002)(66946007)(45080400002)(9686003)(8676002)(86362001)(33656002)(7696005)(122000001)(8936002)(53546011)(38100700002)(66574015)(66476007)(66446008)(66556008)(64756008)(316002)(110136005)(54906003)(76116006)(83380400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KXTNO7TnLd2JjW9slRAc9AMuCrHQP16QTbWLW6lVncfHhTU/Dh7/27TRwE?=
 =?iso-8859-1?Q?/E9A1s8kbPHEUUWNoIB/We2XiaH5vttM/A/bwRwQnjn48vJO0DlmtR0N8k?=
 =?iso-8859-1?Q?+MMh3iTf0mvehGBZ10lx7gHfkW52MRrb1KUkH2MjZsO9dWsYXFCjk7/JZ8?=
 =?iso-8859-1?Q?UKs2c/s1JfjOkqWLafZJZA8Yd0paYbP2HXE0/rlHmReDQgL6jz0eFOOxmX?=
 =?iso-8859-1?Q?cMMU2iUHTx1tdlAvN+EwbRAI3CVoht/QXB6ny6VP7hNsu6pYmTNJgg+Zr3?=
 =?iso-8859-1?Q?WmgoFYwZU1r5GAX3/vRMdvMDylX5Go2vXK6PbMGPwH8TolS1Bfw0IdC/Xn?=
 =?iso-8859-1?Q?WLMG92bHfo6R4O/FM+MULAKCuReqU3tsODGbwieXQ5y00UNeY0OqGyNrS6?=
 =?iso-8859-1?Q?Xuk5AN5vyNHw4P/osTFj1/MAemIAhllg8yEDQr/dZFGuHWTR7bqYV/f+4U?=
 =?iso-8859-1?Q?DcVNwVpboY0KL35my+9NpvJPUWT1XpJDea/1NDNYbNZtqs6hqzxlra2BeJ?=
 =?iso-8859-1?Q?whcmaqJmEU9WVysz5FdyYbdOOFKJ/HSfBPKGggiQwBkUNgD8LeRQDey9ne?=
 =?iso-8859-1?Q?2ow6x/Xk5jFuErvIQDPwDHu3cP5rYEXfx6oJXnrdBTY2XHswb864rt/35h?=
 =?iso-8859-1?Q?3WgkzJ0rfynBVC80NJGlfFcCl+sLoCzxSSWM0mC+by6DPthAWyI7YpfF90?=
 =?iso-8859-1?Q?yQy8jEHC4KBAOtsSTOEREMW+c7XA83WzaAPV3bxF7aod8u0mVkPe9m7aC7?=
 =?iso-8859-1?Q?ubecumiS+UM8HwKLR6Di522Ujq6jPQeUscnhZhgLpgCBOsER+ZhE55EwN4?=
 =?iso-8859-1?Q?xXiIj29yruBaui8Yloo/4R91Au5S6tAhPnde8TSqiEZZ4Lf7KE6MfRUki/?=
 =?iso-8859-1?Q?UCi5J8NX20u85X/pWWUo1A2q4jq+Anz3CFtEA1GzCW3ml+atWiHHiN27wK?=
 =?iso-8859-1?Q?V1Az7WFJuY9MoA2nTL/RLC2+wHnGHmj8IRMW+VSuIHPKcnQgi55EAwvqNd?=
 =?iso-8859-1?Q?J3TKnR5VXiKOMA6XgbfwFe5+VBOgmmg+Tcqxb7FLHONaZg6MSsiWSbxvFF?=
 =?iso-8859-1?Q?PQeAwMjI8wcbUyGEiyi098TbrwAOJMMKo//+fuKl2055vg7k7J8usmPhih?=
 =?iso-8859-1?Q?4MrKUXKJ8SqnnjjeLz7maMXkKr5LLTW052D2DdpIU2pFZvGdIXXNNcKQoK?=
 =?iso-8859-1?Q?tmRFi8RY6or4ooBt3NjTrwfwpuFlvPxMu1cYwXG3ojWcjF+zXixKUCBVMi?=
 =?iso-8859-1?Q?gN+aj6jI59pRzkmPKCDcgQ6w3G2PeZG5+KmgY03meK8SIBG6VcUsoTwYMm?=
 =?iso-8859-1?Q?8vDo58NmLp6QiHtaShBlKQclQlFppO8Gw2FOhXeYWhvN0kKoxoqhLd8cog?=
 =?iso-8859-1?Q?+UGkkjjqMe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2181442-1852-45ef-9928-08d90e4096c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 14:34:41.7855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOmtC/SaI8lPTvB2PHxWfPnkM+Aizf8YBcCTPT9kQpS4WN1X605ZNTLVENbUAEnxKhN2cJ/SseGDPYa3UX7r0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is =


Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> =

Sent: Monday, May 3, 2021 14:12
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevi=
n1.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawk=
ing <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private bu=
ffer

[AMD Public Use]

<Ping>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, L=
ijo
Sent: Friday, April 16, 2021 9:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevi=
n1.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawk=
ing <Hawking.Zhang@amd.com>
Subject: [PATCH v3 2/2] drm/amd/pm: Add debugfs node to read private buffer

[AMD Public Use]

Add debugfs interface to read region allocated for FW private buffer

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 8128603ef495..a229baa88483 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3526,6 +3526,45 @@ static int amdgpu_debugfs_pm_info_show(struct seq_fi=
le *m, void *unused)
 =

 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_pm_info);
 =

+/*
+ * amdgpu_pm_priv_buffer_read - Read memory region allocated to FW
+ *
+ * Reads debug memory region allocated to PMFW  */ static ssize_t =

+amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
+					 size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev =3D file_inode(f)->i_private;
+	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+	void *pp_handle =3D adev->powerplay.pp_handle;
+	size_t smu_prv_buf_size;
+	void *smu_prv_buf;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	if (pp_funcs && pp_funcs->get_smu_prv_buf_details)
+		pp_funcs->get_smu_prv_buf_details(pp_handle, &smu_prv_buf,
+						  &smu_prv_buf_size);
+	else
+		return -ENOSYS;
+
+	if (!smu_prv_buf || !smu_prv_buf_size)
+		return -EINVAL;
+
+	return simple_read_from_buffer(buf, size, pos, smu_prv_buf,
+				       smu_prv_buf_size);
+}
+
+static const struct file_operations amdgpu_debugfs_pm_prv_buffer_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D simple_open,
+	.read =3D amdgpu_pm_prv_buffer_read,
+	.llseek =3D default_llseek,
+};
+
 #endif
 =

 void amdgpu_debugfs_pm_init(struct amdgpu_device *adev) @@ -3537,5 +3576,1=
0 @@ void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 	debugfs_create_file("amdgpu_pm_info", 0444, root, adev,
 			    &amdgpu_debugfs_pm_info_fops);
 =

+	if (adev->pm.smu_prv_buffer_size > 0)
+		debugfs_create_file_size("amdgpu_pm_prv_buffer", 0444, root,
+					 adev,
+					 &amdgpu_debugfs_pm_prv_buffer_fops,
+					 adev->pm.smu_prv_buffer_size);
 #endif
 }
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7C7832088a2ca34c755be908d9008f0258%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637541436501320898%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DPxT=
2L7MXjlrTSk37nP1GGCcWTzSzRWbEtO5w%2BkRUbMs%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
