Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A606EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 06:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD10610E65C;
	Fri, 11 Aug 2023 06:04:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBF110E65C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO6Im7Xm17fcAlV7If7GORpRKpdo4IEbyJzy5VutzzUePTgNadHdXZ/yiu9hI60CpUT+AdCk+ixTJJXf8Q0JkUuzoqFVfURQHguwq6yNy1xF/au05yp5HoCgqMcielSBz/ZQUfq5JBgQliBPGkOHqZm2ILQww7gjFWltcRJ4FRMDNp+7rzNsAj3oDcR+vjoyxafN5r86zZAY36K4ZeyfvX/F/nP0wpew2d4VaU2FFCBDbCzjheTZH0FWBCZ1HcxBfJTjIYtBQngVOKhjhjUa9gLf4lJX/l0dNcpjHwbbC8O5KgY27g3O6IcfZj/k5axQGotGCFZ4tFquwK/WSwcOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiR2axac36q8y5HxRpx/IHR5x0KbNSq43gwgjMsVqrw=;
 b=SovHt863SVNMv57EWAH86rbjx9QquLcknktHPxehM9UQRaUgihyCLSE2EZKkdBRP5u/X3CUbQgMcZErSi1MYAEtLKTjPi1pkiM/djW07uAz3GU71kPkUF3O5phvRgiPYNRjOiJ94w/rqIwcRIxsnw0C2R4K5GmudU95DmQ+zLZVhAC8ahWC2WJvrhs6wq06N0NNQjAYJg2AObXqsCAWcuUPNMRJAOUGFithNHe++6qAEodGmYg+lO5ymwxOqdrXMhOZ9INSp6oeLRi6APiKZIvr/NAvdwIkIctX/djGCohdLMs6of+Hwteg8Bj7sR4vdO8eGYAWUKJhG0JCukxtfhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiR2axac36q8y5HxRpx/IHR5x0KbNSq43gwgjMsVqrw=;
 b=kuVwJwhcOkBTuY2j8NLaz4ZAyOTYOiI9QmKkJM34fhK97M+NrWv/l1WTdrVW/giSSndqft9AK2LR3oLdmKW/NgHjIAU+1dcsQJ/al5oPOSN1Jjmt4Rm8FZ3j9Ch5oMgRcCnC24jYZinWkDpBxszTfiHDfdzAJ4JOpwGz5D4BY7I=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:04:15 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::b4ba:c624:2cb2:90cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::b4ba:c624:2cb2:90cd%4]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 06:04:15 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: bump SMU v13.0.5 driver_if header version
Thread-Topic: [PATCH] drm/amd/pm: bump SMU v13.0.5 driver_if header version
Thread-Index: AQHZzBX3lt4E9e06i0O7/tgqve80KK/kmqrA
Date: Fri, 11 Aug 2023 06:04:15 +0000
Message-ID: <CY5PR12MB6369FA8BABB17F4AB3ECA087C110A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230811053631.2794988-1-Tim.Huang@amd.com>
In-Reply-To: <20230811053631.2794988-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fb169990-7aa1-4a27-8d26-3f3923b88774;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-11T06:02:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM6PR12MB4075:EE_
x-ms-office365-filtering-correlation-id: 4f080a62-a12c-4541-89cb-08db9a30cabe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35COZEEjshbYn9TAY9u2WRCkeiTzDy3hY5MADnI8bjZG1Lq4G4V/eUl3PIpwOMihK3e5dznSmQtsKnBGsjvRSE3RXHv3nMmzpS8bK7eV/LF/9bAyb9Co/lPGvse0LE6GkYDpmp/hm2BvD4y+DsAYBoByJ+/VRdTDQAZILRthno9zVbwZVgb0gYtLNUVrcY4yRUJ/nURuwr6yLlaXaSNXCKFYgyW2FrCBs54cosdgn2TjWn5vpBcHuSsnDGd69Y3MTEj5Uu9tIHImjyjQ6YyBXZzINFhA8Ti5D3a+/uZcoKyUOaZWx1zPgGm7wVDohxFl4FAXOF3FGrSUb1r9YCN5KkrZghmlYEqeQkO7RNuV7nDK35XrSe3Aq+FmNnT7atvaSS58GcAYMNL/C4hPGKCQZeGyysos8qqphZhQTKuCc8Um7Yp5FcvlFRvoFNVm6cFj9H48T4SL/AX7CzJW4ESbIbjk+oW6LLHLMqM7nRHaMVJGngyscANhcjrC1JRke9AsL02EPTeN9M23mcMpyIQD3ziJyedEgb3KHX9A7pgpxLkrLWQXjY8FmOsJgK64a5ny4YiV9e3fkQHz+IS4cWImitnpg8xmXtGllVJLVn03jbvQpeSULT2a9aZD2PptNu5t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(1800799006)(186006)(4326008)(9686003)(71200400001)(54906003)(110136005)(52536014)(76116006)(64756008)(66476007)(66446008)(66946007)(66556008)(316002)(478600001)(5660300002)(7696005)(41300700001)(8936002)(8676002)(6506007)(26005)(53546011)(86362001)(38070700005)(55016003)(33656002)(122000001)(38100700002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yibulnP9WOX0fDDG8bZ9yXowybcxyruo5fN3eheV/Yzyaw56+oD47Mqe4BXK?=
 =?us-ascii?Q?60e//YS3Bql/PtgZ8N9aJ66Ee/f27GBJ4V3J/GYPpyVkqntkqIKqtyXNJRz9?=
 =?us-ascii?Q?o1Rr+PPMT7e+GSVpguY/oiyFxhBWzQn5MLdlZfDI6caX8wRdvpqo/sz203im?=
 =?us-ascii?Q?xI02EpFphYSEs4F40//INlToaYxnu1Pvi9Dgz0yWcs2DvRYFzdcPcEmpIjyq?=
 =?us-ascii?Q?aM4VAYgXsdDmejDgp9MKeK/aELYOYrV1ZaJ4W/bVn0ykCMJAULYFUdYB75UJ?=
 =?us-ascii?Q?JMg5NyaWvpzHaGZO+oMQ9BlQH7sHDuVbE/HXS+0F2PuvFY8NsWcQJO7VOm/h?=
 =?us-ascii?Q?vxbfnXlFFoxi0xS91ThifeYCciLwmGrashH6fhGtrI6tIhYlxC7oixV1Ywxf?=
 =?us-ascii?Q?oT6kbAYOu7ujfcVq89AKLcRiBXov6zWsX/tf6Jj9SmAxz21DkO3EKq1WVxDm?=
 =?us-ascii?Q?MdbcZExISlH3rhxjerHvcUnMEK2EKZcEj51vc16QtKizpYM/agZ+EisWk1Mv?=
 =?us-ascii?Q?Qawr+ZF59nyhw16nTM3ZkctqM92D0deoTQ5Ac1h/1UxtcLuI69FsSIPOeqAv?=
 =?us-ascii?Q?XraLRJLgOeEFmBiyxCjUWRBqsQi8SsrMm8TMqs/6ebbgwbVTTNWByyqcO3wR?=
 =?us-ascii?Q?xjCuZO5kd2kzw8feucuGZ0mHfpkXC7TbsnXCYHdcbr2qr6HOJcMMUG1pb39G?=
 =?us-ascii?Q?R7SK1xqmIPRgUHfyBHHhpV7PRJ+8nWmv08hHLVqRl6UYTgzGwt2KQOnhNKsX?=
 =?us-ascii?Q?8t87VTOBJQCR/lSg1B28Qb1/K2s731rdHbkkhwldNyFYOAgY7pRTI7dDFI+t?=
 =?us-ascii?Q?S0DYP/SmmjQZ8/eQdgNVyiLPbn02Rw4c4yYAc3XD/5nnc2YrswYZOyHc4k0q?=
 =?us-ascii?Q?T6cs8Y/9LuRc8sdr5tiIX9IeoeftN3BHS0+raVqnz/R7EgVPfmVkeuvj/2RS?=
 =?us-ascii?Q?ffbP+PYutCQVrzLLH8VxxTMvYDmOObQ7tTZK2EWdcsw5Lh3MQN3tTaGXvK2U?=
 =?us-ascii?Q?U7Yb8S7N+B1bTGzmGmI50htAbHZ1TIbD06lSdSCTnyUKlXtYgXDwZv3RSYnN?=
 =?us-ascii?Q?Fosy9SLFUzpCZPyQDT9VX/sRzg7UutZksu6L/57F69QwBxGXeH8Vtpnvw1Re?=
 =?us-ascii?Q?m4gDLw+qBvan0RqOsAfh384Sbrvs7S6HJViXCwwhfg+j2tm+scV5oaM5seXC?=
 =?us-ascii?Q?XCDUc+q4RRmR/rXTcdGWYuvy/HUgUxpMAubrvJWw/MxKWBY/FceYfUzhnIMh?=
 =?us-ascii?Q?LhCnKX6Idl3wFmU0j8CXa5b7OVnJO9g8Mwj26MC8fjzLSC6TL8lHg/77eNin?=
 =?us-ascii?Q?DC0HcyMUOa8pSSVFLKiY0WAvc9HjATUaY7A1M0vh3+YCTkYyGgVfai503TBO?=
 =?us-ascii?Q?mYUyqd1g9cjudoYutDMKqTdFJgU+YnOO3f92ao+P1FK/H84MziaXGIa9eT4d?=
 =?us-ascii?Q?GfSHmdGgXE0OV7CEEB3nlIGQ/4MoV1gKGxTpWH1bBmS52q0F6E1kY2umtzD1?=
 =?us-ascii?Q?wgI5Ru+i569Y3QazdN02FwH6QSGcGL/EtfETfck1xGK74BJjChr6NvgOOKtW?=
 =?us-ascii?Q?Sl67tgIEAKykQoiRvrE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f080a62-a12c-4541-89cb-08db9a30cabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 06:04:15.3035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anHraMY8WaMmLMM4w3i6PcCfkfNSe1iuGVgT0Wlx2j1uZy1j1frLQnZokqz5+R3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is :

Reviewed-by:  Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tim Huan=
g
Sent: Friday, August 11, 2023 1:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Huang, Tim <Tim.Huan=
g@amd.com>
Subject: [PATCH] drm/amd/pm: bump SMU v13.0.5 driver_if header version

Align the SMU driver interface version with PMFW to suppress the version mi=
smatch message on driver loading.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_5.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
index 7589faa0232d..779c2524806c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
@@ -23,7 +23,7 @@
 #ifndef __SMU13_DRIVER_IF_V13_0_5_H__
 #define __SMU13_DRIVER_IF_V13_0_5_H__

-#define SMU13_0_5_DRIVER_IF_VERSION 4
+#define SMU13_0_5_DRIVER_IF_VERSION 5

 // Throttler Status Bitmask
 #define THROTTLER_STATUS_BIT_SPL            0
@@ -103,7 +103,6 @@ typedef struct {
   uint16_t ThrottlerStatus;

   uint16_t CurrentSocketPower;          //[mW]
-  uint16_t spare1;
 } SmuMetrics_t;

 //Freq in MHz
--
2.34.1

