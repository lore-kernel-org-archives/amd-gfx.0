Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BC7C3DA6E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 03:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6DE10E360;
	Tue,  9 Jan 2024 03:08:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B980A10E360
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 03:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqwqiwoJfFtzcDY84dM98xv5lY7/6Et3fVaMXgvN1s1gWQZ+88d0p/cdtakpabR6drAll+usImKTHck1L/+IOFtZJ003gsmEWQY8ZBYJcuRsjgA7TRuGRPmDqmZGDNSHn6UuTzhFhxTsuPEFWUVPEIZPSOCKL5wWMBc2W4PFafaQALpjjUg97iGda2CFTHKgDWEk3wqJh67ItJUZP1vafcgTo513p1OMtQXimQdD/bJiHYXh/v1zlCbIqtAkWeEPFGWwH6g54KU1g6JW7WhmjiWTzTpTB8M4fZhZkjUlE4vFtGClxujS9v/BAlugmfGAAuJvdivYF+dpi+bKMyFqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFET15wFOEw3FRQrciRMlVEq9ugC02sq5CdmvLIBqDY=;
 b=fdT6cCu1fY+NzyYM8lNYH2qkT+vhI4i09S9OYfDy4rMWknLuKl18lBAyNVBIhbddOfRWZMRDSmPdhodJf7+DMIkUzLD+xI/2x9tvK0ieQzZ7Uc+6dZnAi+9UA9S+TxnvSrJM0MPzq3XWUPQ7ZREJq9sFMCFKRfTvZPCNC0TU389ROfq3zzeMuTpaZ5eDzF0EK3ul1ftBm+AHVrTt6OAwyHabcJYYuSxFynSg2oFCkDj4YDacyCKWiJRgUTM5RLbEXFIrjYRCJpbqBpIg/pnlfwUhsXSU9KvtRtpo6Sby2Kwz0QPNA71uOG99PijCmuvX2WbH1MEjwrxRa15LnLjGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFET15wFOEw3FRQrciRMlVEq9ugC02sq5CdmvLIBqDY=;
 b=ZIw4C22wlBWj7U/5bFqTU1ZHPpoln8M1OAXSYPnc1X4VSk4KSw9acpkRgBen5oOmzqQy4Q+j4wqkP+XqyG32HeBWGYWtynN/8zaWXCZIEyq/ysNO6WzkoBL7j1ZzIQ7FGUgsdbTkzqcZs2i4UGw0pBZwjwUhDzaCkXVNRAIXXGE=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:08:39 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::24eb:726d:b108:e03]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::24eb:726d:b108:e03%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 03:08:38 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio
 v3.3
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for
 nbio v3.3
Thread-Index: AQHaQqgneG46Oe7tUUuDsy2dG+9gX7DQzH4w
Date: Tue, 9 Jan 2024 03:08:38 +0000
Message-ID: <CH3PR12MB8074A78166F81FC9F1C9E2BAF66A2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240109030030.1138707-1-yifan1.zhang@amd.com>
 <20240109030030.1138707-2-yifan1.zhang@amd.com>
In-Reply-To: <20240109030030.1138707-2-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=60265e2b-1fe8-4887-b206-3965ccf02748;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-09T03:07:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SN7PR12MB7024:EE_
x-ms-office365-filtering-correlation-id: d3d80f35-7f34-43fd-38c1-08dc10c046e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPmvA/U4CxB0AlogMSi0p8HdAfgD34M88UHwrw7NaQIxypOYgAaSdG/oaV5wO7O+lqndCovuIgHM+qjNnFa0CnOEulCaefKEpm5Nw0nUodv3uZp/DN9Fw1eAlJ15/aIOpWB8tAURe0YkqWlp47H3WenNIR3YwWvvLrG6uerZ+9LoyQewljVJa/aktwP7MLCZ7GRksPj2CCRSp6Ss0zSV+mZL1nJZEY3IDXI7VGHB2SWu89IshY5Kqdx8S7VSU5AfNTrNQRs7+A3aZszM14o05mpWEKWGZ9LG5aZra7iUk4ByaYp5AVwFA3MaToIrQscKo763WX+wGNj4749pLiDMACJ6daMj8OKyKV6XTCSh0ZX5BAmn9jrjKmWm3wCqrhbaRLqVRL2c4qi1reFy7v/NGFQj6kjg/+ZaS2hbrhjorozWEWnny1pvfeDQ8FcptfDI/ryS5SlwESJCegPAaUGWZFkciz3/ga+DRlBY1X44qP0pXEArcuhThJ0xdDgZ0vaS4a00dVGCOwdry+o5ssqf5ql8vlJiOjtnJQJaq6F2Nw4tneUXC5uyI73GjL7jj0SfRqRVTAtP6OtClsNFN4UBF8iPd+U95BziuPIzZy6vzJ4AZ5IGAE5l6Jw4goQIHIGO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(53546011)(9686003)(478600001)(26005)(6506007)(7696005)(71200400001)(122000001)(38100700002)(33656002)(86362001)(5660300002)(2906002)(15650500001)(41300700001)(83380400001)(110136005)(64756008)(54906003)(66476007)(66946007)(316002)(66446008)(66556008)(52536014)(8676002)(4326008)(8936002)(76116006)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ERf9KBH8fz1m7mJXowEGOOeCMynRD1cfJ5LGP6ckOhU1lt64KaMTo+CDl4/6?=
 =?us-ascii?Q?8GBHb5Zs/jagkabM+H+yuHserrnIkgQzDLw2VkzC7jtorUOeJdahlhFYIIyw?=
 =?us-ascii?Q?eYAJox4gn7pDZLUfvwMd9TshjLW+hn27KzjNH1TXKXNux3AqDZke4mwC47LC?=
 =?us-ascii?Q?oSQg/JX9Axsk+qoH6qaa/7+OM+gwXUL3tnFRiFLA3gG7bZg1Gx47ChZ8gFfz?=
 =?us-ascii?Q?icbBx0Sy35tJ0OWbh+PJD7vGk24SyBCML/oKaqF9NFDgpe5RGKkMQWK6bWW7?=
 =?us-ascii?Q?5WWZSDgMPPP6yNRjDF2j9QY57Ay6ThNeHVj9172HneZUf6/2m+VxEbJ0Z5xo?=
 =?us-ascii?Q?MfDJZTPE3wPahPXSLjC5quI15DzDYKCQp3ZVCm4TwJbi8XwLrVkh0/du/pEM?=
 =?us-ascii?Q?rrCleVdtXBUL7pr8y56aY6IfyAIaTfOTS8ikYbj7gf71aSM5YGc1aF6RWcxV?=
 =?us-ascii?Q?dlRzOXkr4gmmJkoDfrnQlRyQTxtJ7HJ/SjGlQH1IEuRJFwob1eWzOSo1onlj?=
 =?us-ascii?Q?6cgXXQcYEdVl4EDFc5eMRXhM+Pxkv5abWVneHkgdASpC3MvssToaZIPNwuqr?=
 =?us-ascii?Q?APA/XLkg1zUF/jczmpbH0e/M9BKzeVmpA8zfaApzKbHmQqXjUf0meooW5GI2?=
 =?us-ascii?Q?EmzAzrjWGNcqNoJ+TTL3myNdSS7TJuQQUx25lDG9c7FWPwJSuF5wDgxtrgnl?=
 =?us-ascii?Q?Nxobddb1r8GuR959cy0MS6ipkIvX0ANyp+XPbNc7tQ/is8MkkcPFHRlThBYO?=
 =?us-ascii?Q?qlFvTnNTLBKiFaB9roCoQYimSKMbg7tMSs5D+BXGVJtFEb/1l3ykfz0f0O5+?=
 =?us-ascii?Q?rUfeqZe0WBkYhI+tcGH9Qk1poeG0D+u+mmgrW+ETqgT5mSLXnlOCd48Xjmwg?=
 =?us-ascii?Q?eHVKSATuXcjNBfSfKdLCdsAFg4Nm+3WYsDWoIR60W0tqnkvuyKESK7C+6mRK?=
 =?us-ascii?Q?6UgJax5C9oVd8N2+N1oQFwVsJz0Cwn0LTHqI8guJ+thbSl6+OK7pjjjF8PtE?=
 =?us-ascii?Q?mBrHT6f65wDPDmZGwDTr82LgXNt6Z7Z0F9gY8P+6DmP/sHFBPZkVqh2hiwqm?=
 =?us-ascii?Q?ZpKB4N+5pS+iKGpJoIARgusEvIRmJAQOCFVHBQWraNNYYkfwIghdEJVhYyP1?=
 =?us-ascii?Q?hL3Ue1EMzcVFVnso9qYKLKHmagQagf8kOpavdXGMz+xeOvCdqAh6UhkZiRsd?=
 =?us-ascii?Q?shglN892e7Q++Ae1UWt7bW7H3R+wCep10alX1S8NGmo05h6M5boi6oURFPiq?=
 =?us-ascii?Q?ST2vxi1YDj5TI564+ooAmXFe/qkQfc9k+09uNvQfWh/Mln+T3lfWonyhiu5e?=
 =?us-ascii?Q?+FQDQR41HvdjnkySqvIBEozIHQZHrshBki96GGN3Id8cNKN26zHZGlIqppa4?=
 =?us-ascii?Q?baNbJx5Nk8jbIf5cFoOfB1w8LRBYzk9/nyTMmEPBl/EJdBnn01TmsWg4xiO+?=
 =?us-ascii?Q?ilhj2ocnhqlIv5/1c8SPfWtrJb9K+VLYs2chBU2JOc1kUyd+dNrg6qiXSCqn?=
 =?us-ascii?Q?wpu900bL9C1h/eawex6JtdwrjBtfrNFbeWp3/97KXMao6jk5tkJgZzUQqG3a?=
 =?us-ascii?Q?7L+EFflkpOD+cR1TH9E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d80f35-7f34-43fd-38c1-08dc10c046e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 03:08:38.8426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ha7OFESaMNwoqEPjbjedejluyXogY0e6iZrfw3fN4Vs6VHlqNOznX5vMKy+NItlLvKWvMCTRsWF3gYNEJGoiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu,
 Lang" <Lang.Yu@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Series is

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, January 9, 2024 11:01 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.c=
om>; Ma, Li <Li.Ma@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <=
Yifan1.Zhang@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: update ATHUB_MISC_CNTL offset for nbio =
v3.3

This patch to update ATHUB_MISC_CNTL offset for nbio v3.3

v2: correct a type (Tim)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v3_0.c
index f0737fb3a999..d1bba9c64e16 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -30,6 +30,8 @@

 #define regATHUB_MISC_CNTL_V3_0_1                      0x00d7
 #define regATHUB_MISC_CNTL_V3_0_1_BASE_IDX             0
+#define regATHUB_MISC_CNTL_V3_3_0                      0x00d8
+#define regATHUB_MISC_CNTL_V3_3_0_BASE_IDX             0


 static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *adev) @@ -40,=
6 +42,9 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_device *ade=
v)
        case IP_VERSION(3, 0, 1):
                data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1);
                break;
+       case IP_VERSION(3, 3, 0):
+               data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0);
+               break;
        default:
                data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
                break;
@@ -53,6 +58,9 @@ static void athub_v3_0_set_cg_cntl(struct amdgpu_device *=
adev, uint32_t data)
        case IP_VERSION(3, 0, 1):
                WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, data);
                break;
+       case IP_VERSION(3, 3, 0):
+               WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0, data);
+               break;
        default:
                WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
                break;
--
2.37.3

