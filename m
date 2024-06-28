Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C4C2BBCA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 07:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1688F10E131;
	Fri, 28 Jun 2024 07:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FZ+fCPX7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06E610E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 07:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtPbbtLQ1r0dqOo2JZuhy0dhAmy0z+jl/XbtDgH9R7qrpKI/5Avktf8ei1Gol/1QYtmSxHCtMIPBK+pNiV9o/F8vVLlupjq+y2CNi458hZStIYarJvfUTZ+bKNbI2EdTa2lICyXOfOrQgoE4Ywl9w78GFqVwkqGP6PbtuTBkFhMK4Uy5VQDJN23eTOYy/TzVH1OPkK3EIoaLZXQ2Q9Y6KAr6SGp2m4OUgrIsMxZsQqy0MnCny/YAORJU2enlWqCaYD45dD4A+FGAjJMacVejJjzMoku31HHyf4M7K0ENrOO4nlmf9/OUjlx4/oVhjC4CHfLY3wVdvGB1msIMhoMJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rOm8sd+NNvJCwjDoHsnNQbMH2XqFY90Lml7yz2SGK4=;
 b=jXsKicc6mrk1FsIS6HD1qEKOGxEG7DIkFc8W6aDYdHUBYqRl2G2fNwR22ZDpbOxFyF68Anct6xx1aVLH3Y5RxY8LdTO6Ii1u5lG0a3IwRm/Kl7KSg6xvK8vqq91TllF4iH41qv9hZt4g4FbRld2G8iZbiF6oiIGDh05eynmZqSY9IrdH+QXMJG6VkIWMSqPo2nWmvwS3f/jXvL6DruRFcvJ9s/dQFufyryuRjpmvxDuN9h44Tn3S+W+sPxoY1yovxnJ0P1xtNgqNptM2VmZOvzkgcObeAQxYD5nioFoBs9Zk75YFi0XvFP2iFvLs0FUti7SMvt8tOtH9oi8pqxqVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rOm8sd+NNvJCwjDoHsnNQbMH2XqFY90Lml7yz2SGK4=;
 b=FZ+fCPX7ovsp01XSC0H3gUaiRm3HBnovKlpbyGALt0vpcjMTBfprPsaf2qGKSLOy8gPkQagNx70cQvj3vRBsAnox4imzShK9LRgCNS2CHAfnRhBwQeuCE6zk6Y1Ti5b2Zzyb6QHCH8Yf5ebfMFIwZssEnuBbuXFqCrOS8Llgq7E=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Fri, 28 Jun
 2024 07:36:03 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 07:36:03 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: sysfs node disable query error count during
 gpu reset
Thread-Topic: [PATCH] drm/amdgpu: sysfs node disable query error count during
 gpu reset
Thread-Index: AQHayS00KPtRzwkDGEGycg/OfeYtX7HcyPaw
Date: Fri, 28 Jun 2024 07:36:03 +0000
Message-ID: <PH7PR12MB5997516A4A160F9ED9B0A82D82D02@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240628073112.1291140-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240628073112.1291140-1-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bac958f2-e0b7-480e-bff7-f07776c82694;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-28T07:34:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB7679:EE_
x-ms-office365-filtering-correlation-id: a9a8d438-2e7c-40f2-7c05-08dc9744f6b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7cCDOnqZQSuO1J7n2tTIqrFBVvbxzbG3qhUMo9yskGq+Dsl7IykRw2LVyrhS?=
 =?us-ascii?Q?04MSpOelSe3qCpf09zVHtFpUVihu4Grh/v9acHNpVFLzyEeLSNOccPN8o2aL?=
 =?us-ascii?Q?Iv/w0kHDgFOQ2XJHI/wReexLgfMjaGUMoyD53pfXQUt+9YlgsYe1GsL9vCqY?=
 =?us-ascii?Q?sw5sA/44IIrtc3wvfEv+MFOvGyFzWmFvs7Wmfbkzs1Q40XB2cKeObuiEaIXe?=
 =?us-ascii?Q?Z+aTxKbonnozJwmBjWTTsGLfxxam66KMFP1ZntQRxA/OOuUhEgOV2FqhgYNh?=
 =?us-ascii?Q?xBQ8Bwaerx/tzGke8PbBv7e9gNsCQqMyZSbeD8VsBvXKmlHznB/ZwtcJz8Q/?=
 =?us-ascii?Q?WO6dkxv/ABIzPsivFkvRkKZ5/T5PoHV91I9Yfoxk3Un3lhKnSjc5ImTL2BUB?=
 =?us-ascii?Q?0LXK8wUpqneWYc8ljbZRRVonJXxqXRMTmcAbMJ9mvmyHx8z/+p2DD6AiglcX?=
 =?us-ascii?Q?kNRY6M9QqoYRF35syGqtBRUfsdyH01OBUMQ0JExGZ2ZvGpgPAsVxjs24ECln?=
 =?us-ascii?Q?qwhF3IBQFfVGi/H4swYnVe26/QMXkiATqpDHCrhbPhiNaApZqLIy2whldRmc?=
 =?us-ascii?Q?orbPv6UFYRz/6vqoPup+cIn7IwtI6+hfOyfx/pyTnYyWRJIwZpHWSezNXIiM?=
 =?us-ascii?Q?TYib0Jn+PlCndnJXX/quBsEhjsZzwvY77d4xSNytIOlnyzOJCn1CVR4ddDj5?=
 =?us-ascii?Q?RfwjAtuz59mLpMgwNlX8/f8WC531wfcs2Wz+HWWlhPWR7QCQChVaYmaP9406?=
 =?us-ascii?Q?WbqseFbNM3laTLtWM3eFOtwevVpFoDFtF8wnb5LO4NDOZu97EONO8LPOdI4E?=
 =?us-ascii?Q?fdJUbiHMXAMMl5RUKDwudOqK3MZgI/BX2dAwNjZ++y1Zg+rV/b5crHZm5/Zs?=
 =?us-ascii?Q?vV84hkG6YKQQZAxnHuaSf48U1UHlumsmNNJrR+g6Pa4s4ihhzcoMjguvUhD+?=
 =?us-ascii?Q?OcX0VohBpc8A//NMg1xI9AVjUFDy1lqfUXufOivIzcAVzt0IqGDEJiH1/wgW?=
 =?us-ascii?Q?FCnbBCqOWtcJefXQ8iIgZhraDSUPjqFnJucxQEcABrZrqnorZtSIGAH04i/v?=
 =?us-ascii?Q?UtNAQC5As9JLfIyKZKWebWrJ3QWjMwmsxhcpQdKrMwsDf9snK3jtXLUctrUD?=
 =?us-ascii?Q?/uT34ohEl9eIq0X3KEJQjeG2gcmhLKL7gzDCZXibLm0sU7ENufGvkfW5H3Z6?=
 =?us-ascii?Q?KDEXflwS2Zd6NnIUTFPjjtgyUiR3hyy/Gu+PSC/9uLPkcNeqNthYcpemvNty?=
 =?us-ascii?Q?VWL2gZD5oxJDO8d7SKLtofFIzrJU3lYVIQ8J4Y44Obp4YIL/Wp7n8GPQpgpf?=
 =?us-ascii?Q?eeZ3kV4CO35b6WF+tcOS79cn7l8MAnqRXhKgLwW1wId+1E2kwEdtx6BqejFZ?=
 =?us-ascii?Q?3PBrw3gPTBOoAiqSkQZoKjlL4471PW7K5eQ0gK0OFDh3crOxtQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Egy7WJQoaHGiniRovsBqcx3R/tooRcy819c8DZhFrlFdCGzpHo92N5ttXx3E?=
 =?us-ascii?Q?/rz/l6b1/u83asFg6obHES92IdK219ylqzjysO3YzHmwB30UFlOYN43wvONh?=
 =?us-ascii?Q?HkHTE0eENVty80G+FE4mMM1kkUUx0QzH8q4YCSnVu5sitNg7ihcpFpFSCI8X?=
 =?us-ascii?Q?BTz8KFa5k4s/ND33EolwpxRjR6t1lQRjqj6RcRnrPhBEpQtLWeWFAoPAzyFR?=
 =?us-ascii?Q?iQpQv6XbYyNUupQRKyKHmydMK/PwczbAIuapGET0R122AjuQWEYWf+/3EK/y?=
 =?us-ascii?Q?mn6zoalucUjW205Mju5xCUIuCzap4zdYUE0LYP3KkaD93tvjWU77gOuNDeeU?=
 =?us-ascii?Q?ldrZJmYpw0cVCby1ikWFRK28fFy2g6kFdZJPq0DJqb1ezew4Z/18vYM4sdHH?=
 =?us-ascii?Q?0b+VTQElUN8sbnmKN3TgzIpPn8GD3SBao8b/Q4ebMJHMaV2UuJjvCU5skmP3?=
 =?us-ascii?Q?PeSnq6ftiuoEZXZrEP7HVd0hWH7RhGdZrIcMB9iYCc43Wu6Ks/b2Vtg8sLSF?=
 =?us-ascii?Q?00H1Qyhw2Q6hGGz6zaMig3KBfh/sFSLpghMJkSzbfBwucTJJEUPHLvV2U2VU?=
 =?us-ascii?Q?QbD7LSaIIXQQJcbgLpZRv6nCi7TuNbWebV9GgGZ5sBSJR31UrQ10SccVHRuY?=
 =?us-ascii?Q?Bioeb5T3DXVRMeSXlKswe2tXciPkkP8gDKZwT0uW8BGUgoGEd5uWscsB0MKa?=
 =?us-ascii?Q?tCSA4komj8rfzOAgwKnSiT/0ORRNBOQHDKL6+N8BaKlDaEidMhI94+2j+XY1?=
 =?us-ascii?Q?upyGhD6MbkOtpLpEPHyI9zCx215PUYo1uTYiSdBH8HUewmF+hrZkd1ypTl2s?=
 =?us-ascii?Q?6WSj6IhUPw87P8OySmMCqR04lg6nZSrFKO6w+PuFraXLG/ln/N5Ll0cdaKWk?=
 =?us-ascii?Q?7/HIdqf8xjjmSWMmQUlR9c+VSyZpIYyKPB0nNMBkz/hgcQ7dtqmqiou/OIQP?=
 =?us-ascii?Q?GVqQVF7XWNu1taPqQZmjX+VQS5z1HJvcQ38MPiZt7dmd/fMJKjsjsmJNlhj+?=
 =?us-ascii?Q?BTLJcnaN6EKlk0yCY5jf9U3uo1zaUiUjlOenELnTK2ftwKwkRkZZoVuGVGGQ?=
 =?us-ascii?Q?uqH/H/+9psABWlglBKi7Chere7Q68HmBWzYAG46KapG5bpWkdxLXo4O0hVz3?=
 =?us-ascii?Q?XFfm0z5+K9a+6jBNOFf/bGS2PmFyVxZJ+3OBReQHJZ60AMhSULLDRgBpj7iM?=
 =?us-ascii?Q?WbDaS6kWTzsVDOpJ1Hq1iZsLA3jHhPz+3K28Jp6UqmGo3K9xZsECh5w79DsN?=
 =?us-ascii?Q?s90+ErTjqCUIbgAm89pL1PSUzCO7+vhrHo5dRTlYho2k5P2YDLyAkHok0TkN?=
 =?us-ascii?Q?B03hIhpVeOVJ93WaGvldN4HMuMrn2ACG2x3i3WvkdMJvOtjfVxJCSZDpud2w?=
 =?us-ascii?Q?vIZ+Js5NtTiTTNklT8pK/TZm0xX8tW4aq17aWMS312dGAqLSTfBKVb/RJirt?=
 =?us-ascii?Q?oWRX1RzUuHYIhgkIkd6SBq8ZcLiXqn/GJ/yHrQQNJd6CA4x9Rwp2TPZA/ptr?=
 =?us-ascii?Q?KydKlV+Z943RWe+zbitEk6uSCFwFqkv2xhE1ceB7EY70V50krZro2sLPJFGJ?=
 =?us-ascii?Q?KatugHCALeLbIRP9Xb4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a8d438-2e7c-40f2-7c05-08dc9744f6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 07:36:03.2255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PePSvBh3yVJ89HwqlATGImAKT9AFZNxYXQXfr/K/KBET5RouADT7v8DKJd041ag6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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

[AMD Official Use Only - AMD Internal Distribution Only]

it is better to apply changes on both ACA and MCA path.

Best Regards,
Kevin

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, June 28, 2024 3:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] drm/amdgpu: sysfs node disable query error count during gp=
u reset

Sysfs node disable query error count during gpu reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ac7ded01dad0..ab2e11e1639e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -619,6 +619,7 @@ static const struct file_operations amdgpu_ras_debugfs_=
eeprom_ops =3D {  static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
                struct device_attribute *attr, char *buf)  {
+       int ret;
        struct ras_manager *obj =3D container_of(attr, struct ras_manager, =
sysfs_attr);
        struct ras_query_if info =3D {
                .head =3D obj->head,
@@ -627,7 +628,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *de=
v,
        if (!amdgpu_ras_get_error_query_ready(obj->adev))
                return sysfs_emit(buf, "Query currently inaccessible\n");

-       if (amdgpu_ras_query_error_status(obj->adev, &info))
+       ret =3D amdgpu_ras_query_error_status(obj->adev, &info);
+       if (ret =3D=3D -EIO) /* gpu reset is ongoing */
+               return sysfs_emit(buf, "Query currently inaccessible\n");
+       else if (ret)
                return -EINVAL;

        if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0=
, 2) &&
--
2.34.1

