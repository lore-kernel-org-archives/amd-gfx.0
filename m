Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E78BC52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 18:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D1310E034;
	Tue,  6 Aug 2024 18:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZWs/go2h";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A61010E034
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 18:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1kisYZqLFrRlvqPgovs/ebVJvMed2gGO4lY62yQ+Yh/O2Yau+XL5FEWw9wPWGjDhd+eSeWxzET6fF10tZXn+RwGUwr3Eb/bAid45JBI8Rn/YIVreBzy4S1Aip9cevX/de7683hz5wnfM/t7XRCW3e4AY+45JycaXJSoHRsSUhr5oD6tjDCPgalDKw/04BujIGTsN5tckEc5UzcVkvP0Y0x5VZ8cTWDewEAp/fuDfad50U1DKd1w/tbB/LwFIBgDQL2MuuD4PmrF07v62+dGdQs5/AAGc8djlSispZ5bk7F9vp4hPyw9FmfULjZT6YDqvCV/4Zjhs8GormQnoOWlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pitykECKpBsLyTeR1PgJbHkxD3meBxrucQ2C1HOWQEM=;
 b=n8NkEwwY/fFQ3QOK8bHNhfrL2GgQ+1LGoiGYhX0NGgOXiPRkzwCc3W2PxoToVSZOapxSW85TGmxbWjipbk6ZDDuTvzWMoBerXgE7q99m2BCKLQgZXBi8tn8dRAm1YbHViz/voG4BDlm1zanqItpaqJdtKozleKLTcco01TzBcl/VoU2KYnke5TQDqsymeiCJxcxIhy4Vz2KpolgG6CyArJ9n/nG+YcoTis6jlsDv9YVfsozc0MdLxnZK4v/hB5qIAgLoNZyrC2y7cuPotrqws0FHWGRL9128JCc5fWhGXjxDRPalZHd7CwU8biCIkQuaI13Y/EeNBi2Gv1ci/GM+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pitykECKpBsLyTeR1PgJbHkxD3meBxrucQ2C1HOWQEM=;
 b=ZWs/go2hG8MzpHuh+BPW4gLm0PYsjk0bsi8DifFeKIs4mFKHJRXQ1h2D9X2uIkoPsA3Ety9VS3KcRh2y5LFBP8FI6N/DjJUlgHrm1A93GPFCz/bDYpPL9bOule76GM8X0r5lFrXJcP2fPujJSgXB7ji49NfbtIX09ERtoupHzFE=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Tue, 6 Aug
 2024 18:34:29 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 18:34:29 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Yao, Yinjie" <Yinjie.Yao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5
Thread-Topic: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5
Thread-Index: AQHa6Cru2r67O4g81EWAvAylWdKprLIajaVw
Date: Tue, 6 Aug 2024 18:34:28 +0000
Message-ID: <SJ1PR12MB6194CB78E140A39EBFC4BCA495BF2@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20240806180255.196821-1-yinjie.yao@amd.com>
In-Reply-To: <20240806180255.196821-1-yinjie.yao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f57a2244-4e13-47d9-ae2f-4ba07b2bef2a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-06T18:32:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: 928d89b1-3130-4082-b652-08dcb6466818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4vsVqquI5SdzUqc/IXEm+W9apDDA9YXGA+tXInM64yI18PJi7R0OSMzqWZQ2?=
 =?us-ascii?Q?hyBq8qGdaZVX9kmyVDJTL+hnf9AxrYWTK5guAM1lkstRtg0gR0ft4cXKa1Wu?=
 =?us-ascii?Q?CxhQRQIHdv8I5gYgwNMkytXCY2javGnnpbE0HWcAlqsSNSern7lQcUV4DG2n?=
 =?us-ascii?Q?lt6rNMaFT91I0wVRMJflFuKmUSqQeh0hIGx9sTQi65aaYP6x4CLoVB95I+I/?=
 =?us-ascii?Q?chDhrWsCLwkwvSiy7+yGY3TzqmZ2vqWFYiHAPU1fTtNOLHM8MD1Hn3mkrUhJ?=
 =?us-ascii?Q?3MOne1WBeu8b7ouKHepQZSnlj8f+zqsMpDMLBPkf9yqlnKAHssUqGnn2XQjk?=
 =?us-ascii?Q?IEkU8o2pw+Il4fv+OTaMT9yUqriGqTUhbsfOv8jwRuJuNCXkgL9xEOPfeN3D?=
 =?us-ascii?Q?zoMTNWR2Y7pgKUkiSkL2HqlPJ8tf/ZFVQwHp03MWs9rz0WUYY+C2PlhJ85oi?=
 =?us-ascii?Q?3yrvthNvJLzs1EFfrmLWf9zSf6cWG63KlXT1NSHJGdsrb6jXmpGSlEsj6+3r?=
 =?us-ascii?Q?yHSWJSfdPMcQ2HPLuHOHK0H1/unybbkkr9T3vwsNlQ2Fg6dMPlhc0+d+b5A+?=
 =?us-ascii?Q?SZwuAmX6u36csfqUUA1A9TIMawPlpf5TsQU9Vc6RO3YmAR50uadARPEZyfTW?=
 =?us-ascii?Q?3GBmqDYqz3kus8fUPRZTJ/ATKSeujvk2ziEdTH/cofPBNTiW0JtT4dtWl4W6?=
 =?us-ascii?Q?fvpR5m+KfehhXQf6RnmROvqaz0W02ooygyhnse0Y3cgh9DzxD8co7VFn0MtX?=
 =?us-ascii?Q?9wRUombSO7RMGzTrxRLbcQZYhqBtVmcctuulnEzkar6Z/8qggiO61Ae3BaHX?=
 =?us-ascii?Q?9im5Q/lyVMXM0Mkp+YYaCDFuqXTO0rukb/vVjkdDk9MTiPd3Xnejt/orNlfk?=
 =?us-ascii?Q?SPRAJu+FS0770yBKWPn5g9HpyHsUeMY+iAS/12PHcv90CGMHCDdSvXCEQy2R?=
 =?us-ascii?Q?IkbypbdwHFmmeWpCwal1biuD04jElsy93aE3GOpHhZd8Jx/vYUHd1qmWIewx?=
 =?us-ascii?Q?c49FCKM3A8RG3N3k4HVObvEcbPVY2YIW4EVqApSMrgvGGyatBh9odGnJqEYr?=
 =?us-ascii?Q?uPJBhabcSXTubpL6tsVrPDuLGT/3eSZCIHBmtq+yR1hdZUlPYsNxMMGRzGrx?=
 =?us-ascii?Q?WQsAwkElsk4thdYOPmZXxj1wWyUeLbJbz64CJgK1aYqNiyOHXRDQxqE2z3EU?=
 =?us-ascii?Q?r4nKZ5qoW/SKP2VWWuHQDBTCd8E+Vk3+DIMDP+Juy0hl19xZ5fYgyTxR6dTg?=
 =?us-ascii?Q?uARwkh6q/roc2ECrEcjRQ75P8nt+V6xfAZt4YEsyXeq3NLN3r3OLaTDgRR6m?=
 =?us-ascii?Q?XATHgn0UYghCS4jQNTH9U/m4xF3xKWTUVoCXSrKKi7nvpFU5uqG3wYcIBJzt?=
 =?us-ascii?Q?AefzRDk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W6+DTYQREXWixnOAOgl9BF8YvMfjOhPlB5UKkS1Fz77wLJgYw4dA++egSysY?=
 =?us-ascii?Q?FLGGNkCrzJ1ATLetkbtlYScyBQd5xTURwrjKOF9NGLi9DfyfDJf8MsK7hAGX?=
 =?us-ascii?Q?Td4FIz4/6i1NLgJPzird6RaeVkfM/57611aC5DjE1AuOo7Nrz7ohqUoCdgmc?=
 =?us-ascii?Q?HQyAQQMAIBOFM+S+YHWPCblSlpQQYSHMQbqPrnXs7KCGXScbq3IsU0WUw10A?=
 =?us-ascii?Q?1zchm8CK5EwLk0j82fBtPnPVG8dVFDu5O2ENfvG4/0kZCeYAXNbAEksw7DPB?=
 =?us-ascii?Q?x4LnU8Mdb3UYRY/aJ8sxx0AxgRi/Aq/hIcMWKffkgu5rPcweOxy06E5o9btT?=
 =?us-ascii?Q?4MCCgmU0BC3tOO12BLT+raPQZiuneDuqq8124nhsrhrAhTiPBZNdJ3hdmFyG?=
 =?us-ascii?Q?2XeZPmjRpTvKfn7CE0dKrdiMXG8xLqI5bPBF+Y8n54pzIyqTulzwezgJVxfp?=
 =?us-ascii?Q?sMzqGkYvhwNRYOus34On4tqdfUGusVv9xyZEt83LYGvIo917O6tZ72j7wg7X?=
 =?us-ascii?Q?BROIBx6Lyxs6unC6NZxN4qchDQU1dK2wdzWOMwBFb1G2rxkrWf0Mx0mK840W?=
 =?us-ascii?Q?1o472NI562hXl0U1aUFQAfYadMvIcOapdwQOnOdjj0wyyM1k5CsG7JqOVK56?=
 =?us-ascii?Q?v8vqFhVLYwUsITzYKEDBQ/w5uuvh5rSWmCO/HawhTsssxh4CvHeJV5uX4kLp?=
 =?us-ascii?Q?jr5VYYdue8fQp017lvqic4L/vcYK39BkmlIJdvSl88Q/PSdJuPRDD3KC+n6f?=
 =?us-ascii?Q?r0JM7Xz5kJ0p+BorjLATx/7VRwl4vtdrt4LPeNEJh5q5qwCU66Z7NVCWiao5?=
 =?us-ascii?Q?JQfzQyiwSgXYQNcW3dVJz6JDPQ1RDw8UqNTJxoKxqdpXws7kyAtuDAOIWoBi?=
 =?us-ascii?Q?j3N5ewMrVFjG8ei1alMS75tLCq9vN2djumbhHeTRfD/+WBxhkZGBuLEQCpbt?=
 =?us-ascii?Q?mcgle/1a4k1RJ7ECCaw1QC7XOD6ExuOCBLi9plA4DfAgoifKm4EaJ+iIJGgE?=
 =?us-ascii?Q?dWrOlJTP5GXRkuUCokGhI2H0H0L6j14wO9YD+wFDg+yzzWc6n/NNbP3JGj/Q?=
 =?us-ascii?Q?2RrsTGKHvPQfN7/6EOHmXAQ9PUTiuLL8Tp2UHVS1tAS9QrXDI6s97bnXShvG?=
 =?us-ascii?Q?jilr8rcZAh8nTkrG310ti6XE1ZAOWGjs8IsI+qlY7RfhAxEuESSnRsLv7CEv?=
 =?us-ascii?Q?ieivZq8zKxUPAIhpEgZpDY8SWFS9Kzw2TWxdCz6bNI/82J9nUpJuMxhaJ4lD?=
 =?us-ascii?Q?/kzsP4sGndwE1XocCPucthsmy02ZdG3ZJ3Ooqjp8f+fkxJbtI3kZ7JoIqKkE?=
 =?us-ascii?Q?Ja+mOun29I/MEG1ZU2dMMFXEEFZxy4IKpnRQ9KUkVzuCEiWeddHJmhpEd1ui?=
 =?us-ascii?Q?ZaYnOuLtRgplGuxrdpkXkgRY4EpjwG3Bsd7+I+YSkcsp6FnwEm9mjreK+Ozh?=
 =?us-ascii?Q?TLgEEwd+9twfpts197mivZS/7ypGxuoOsbQA5m7gPLPZMZ4r5hpeR31N1tYp?=
 =?us-ascii?Q?edKgLti+6OAJg0baMCkpH9xnIiwTZTNxDdOwxEvbc4d5xKtBp3fSdx22UtK3?=
 =?us-ascii?Q?l1CXn6gphgBGauqz0H4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928d89b1-3130-4082-b652-08dcb6466818
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 18:34:28.9671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IueWrwM1aB18yas1J+G5JIBXPY2vxhdqqTGGS35KnGOiWqyr6yZGXZ7UTrbwgY5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

Hi Yinjie,

Please join the email group from
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

After signed up successfully, please resend this email with

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: Yao, Yinjie <Yinjie.Yao@amd.com>
Sent: Tuesday, August 6, 2024 2:03 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Dong, Ruijing <Ruijing.Dong@amd.com>; Yao, Yinjie <Yinjie.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5

kmd_fw_shared changed in VCN5

Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index f127eccf59d7..2a1f3dbb14d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -464,8 +464,11 @@ struct amdgpu_vcn5_fw_shared {
        struct amdgpu_fw_shared_unified_queue_struct sq;
        uint8_t pad1[8];
        struct amdgpu_fw_shared_fw_logging fw_log;
+       uint8_t pad2[20];
        struct amdgpu_fw_shared_rb_setup rb_setup;
-       uint8_t pad2[4];
+       struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
+       struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
+       uint8_t pad3[9];
 };

 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
--
2.34.1

