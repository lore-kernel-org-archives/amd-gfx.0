Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340F4C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 16:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B162310E336;
	Tue,  4 Jun 2024 16:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wqc52PsT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4351510E336
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 16:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8f9pFLIq5zOhv3ccAAH4LjuFRhGeBex/pMx/NRgHnl8NUksTwJMHlD+ibkrX6g7ZIOnZG7AP8sql3dB3v0ENj4fP/eVNcuGIUAv78/N9gmDXT1T2LxuUlxboYNcyfD832wpZXeAopP+hteUaAxc8dBbLCZ992SKMfRQNFBonOZWWwdhn5E/OAxNPW5dktYFN+ulucoU+faJdJUDxKsAE87hqr3jB12auaQIDPEMxN2x5CAhhCsxyTSkksb3EJeMg3TqOkm112KnbrgMYs52DKc5G7Nk8+gkNkaa+0xzEdcSLQIs3PuH1HkgW+21h0x6eLL69eBKCoGR7icqzAPX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq4pWIu2xp5YY2lWvWSDjQ1pdGJ9dHsmjdHLaQFtyxc=;
 b=IWrFQWwtUY09fgfUpcrggeeTtyD0gjlm16s2zUrFavq8hIbmZT03hU+SqN+2fSy9VjdKMJo9iZbK3SDAVhtxlrGuJK2HjJ7nOljMM2tI6R5Xiu9uIYcaGSJtT0M7HzhusLqwJa0p3WKCo/EIAC928C5SDEYTwuJnM+8tcUUTmpLfH8npWEVR47/jqgh5+zO+oywOaVs5XrjZ9606Ltj98+TcTY5p5/lOdyqMmyGgwDwVaeNhu/ztvuzkXL6JUkdGWLreOvuWDFtodxVhG87mRx2Pz4HE+kz1nq60OQ0/L45jPJ6EjI9KAQa7YSdlr6UpuN+OuSdMG1G5MQ35e5rCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq4pWIu2xp5YY2lWvWSDjQ1pdGJ9dHsmjdHLaQFtyxc=;
 b=Wqc52PsTkwZUEFXpZeF5raXS8HVZMQ6MYOrEfBuF10LmKGCSd+7U3v9QMNpi3p7BgekDR2fRWbfHHKdo9EUQG63fzX/RByES/qDrOPsHYoaVS/6V5+shrn2SvnzxOm6Hv+FNwb5RSnsXubUZZX2LGqMLX8apwSCdeZZ9GY49DAY=
Received: from CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 16:49:19 +0000
Received: from CY8PR12MB7415.namprd12.prod.outlook.com
 ([fe80::3f74:9380:7a3a:6929]) by CY8PR12MB7415.namprd12.prod.outlook.com
 ([fe80::3f74:9380:7a3a:6929%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:49:19 +0000
From: "Zhang, George" <George.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: RE: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
Thread-Topic: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
Thread-Index: AQHatpb2sklW9OLaskWPg9eNPUUXjbG30LeA
Date: Tue, 4 Jun 2024 16:49:19 +0000
Message-ID: <CY8PR12MB7415814E1314E87EA7F1D23C94F82@CY8PR12MB7415.namprd12.prod.outlook.com>
References: <20240604155027.542271-1-alexander.deucher@amd.com>
In-Reply-To: <20240604155027.542271-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6a710987-b41d-4641-8ac8-6af8864560ae;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-04T16:47:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7415:EE_|SA1PR12MB7344:EE_
x-ms-office365-filtering-correlation-id: 5afca20c-c73d-4b84-078b-08dc84b64739
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZpvPBSnqsCwCnb0P4qSXiLTWPzAXy8u8NhspqpD824fwK2cawn/2q21M0iaU?=
 =?us-ascii?Q?d+7T62cEH6B5c8tQjjR7CFcEW/q7/HveC0atEmfXYrKnH8MW5Ih884wmWmY2?=
 =?us-ascii?Q?ikYMAhNqaqFeQY8wk9fEiXw7d/AXdhWKJGZSB3iITGi8PsKxN1dhjGkYzXs4?=
 =?us-ascii?Q?JKnNvDLbGGU4TFLn6n87XMjgk2G6BYtLYgOXe6CYNLqNAVwc3J+DoYtkLNLv?=
 =?us-ascii?Q?T/3JxkRCxejqeq5zHFDaabvpyew3MARmxYlLEXb5s/MeYO5RQYsRt3MQvOM8?=
 =?us-ascii?Q?g9Xj1Rr+96zm//CxC+poD1qgfSDWUUtjNI7ygTsk3kjZ4Afq7CzmD3KEGHYr?=
 =?us-ascii?Q?bhrHFkBU+EkfJr+crNtGrf5M2hx78u5ge5KrLZhpJCQLyLUyTkCWMOt3mEpm?=
 =?us-ascii?Q?eJLRQr4VHa953bqYht2S/56f6eE0wBv9ELUqqOY7cq8vCVQcxOt3TcW3JaCA?=
 =?us-ascii?Q?i+CeGlKxbwrnWV0tlS0S9NJF9cHi/c6HDjuwJyMo0O+aXsyVbkuUeoIIYiI6?=
 =?us-ascii?Q?Jjc/qxRktXwLx9Y1QVteqGkVjdjVnh+J9saKWmvcEwAhHrVMXLRVDAhVBUzC?=
 =?us-ascii?Q?cgd7Hy8v4I19ATExZHFWXHckQ6U5hA4Jo3ooyELtfUt1bTLuiPNKVPD1EKnT?=
 =?us-ascii?Q?P1tWaZ1bVd2I1VT4UUjzkEJcoFyyIc4iSxL7TLKPiGJ3XTjUPWlVVi4iLxG+?=
 =?us-ascii?Q?L0sEXiErzXL+gIKcTNdXokgg9hVCxbxoKJ381eWefBScodpCJnquN2Of3/gU?=
 =?us-ascii?Q?7yAw5FSqEBPATBRTZxNAt335UTBzb1POg/x/ag1Lcrqw6sxH9duBr5XV9M6K?=
 =?us-ascii?Q?pzN1FahJqUDDS2fMUhWVfgOzAg1ijXMQijgxw8d9MFbH7d5bpwx6/9H+SplQ?=
 =?us-ascii?Q?YYetNagSmcLXZAHXE+kTq0LKNNTg7UuAbpm0krTI/qaQZeHw5PTAkxHiQpRH?=
 =?us-ascii?Q?CRD31CF+eLN0bperm22l6NJAZJo5SbLLrdILkn9wOsF1++l4/VWRq7mFfLQ8?=
 =?us-ascii?Q?1MKCEq9XBqakajWhcRcf7+uy4a2kPQivMG6fGkeOa+9UPI4WjUSWX30zR66T?=
 =?us-ascii?Q?jK7598U8+Rdj0XIuLDmiKuPb379HsqzKXXzpZD3ue11Nl+f08iXMfPumd328?=
 =?us-ascii?Q?/cJwmd7fnC1SoFbftgh4Q28izLr0shuuImt7ZxteaoZgGubwNPscv3jBw6g+?=
 =?us-ascii?Q?5y3apl5BA10C7+Os8jz+Gkm8VWn2QmojyUTO4KMvO6+If9dXZ9du8WqzorLh?=
 =?us-ascii?Q?RGtgK+jCR63035OA1Tw5EVh+8Twjh0pgqySdvaWDYf6KxWaxOcna2Sfx9SnY?=
 =?us-ascii?Q?xroJuH74OVHZjbk16FsNfEW2Unad/w3iuFi6+U7knoGJvA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7415.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qWlEmJSBrKmThPEmM4hjkaJXgEOEYUcGC2p8ooObAa6mPouJ6zE5f/NaxW/F?=
 =?us-ascii?Q?DOEdTxrOodTj/M4TgKuhta9yxRRld6F6Q9YhniVQ4mMGQyhne5/fcJAoHIds?=
 =?us-ascii?Q?RJEKMdtrJ1YoC4LK/QZyrai5k05iRTczI1ad6EnEMd6uFdKtidTYghZwGFx1?=
 =?us-ascii?Q?IoKxomlQ0hMhb0jaS879RIvkIvldMMtvVG0bscYj0GU6UOs8n9SoXBKb6wlT?=
 =?us-ascii?Q?/+yMxmopieywfRAjHNZ4TFw1I9pK/icCmuP3cC0c8sDoZWw87SkxGwIznMis?=
 =?us-ascii?Q?wb7Up7pvyANK2yOQxRIyu06NdyS1xlsvzJmPtJRsNrAFawlHTCopN49aW0xM?=
 =?us-ascii?Q?NIDTI2br0C2XWKY/En60y1uafTJjJ0m6u8kP2Z+e/gJcnsHbGpnHfBEsfK4k?=
 =?us-ascii?Q?AmKjxdnX0zQdTmsx7igYWRd3eK+cWrz1Os/M009NG9ymyeXseaJvqQx8IkqH?=
 =?us-ascii?Q?jqIid6U1q1LYZxXuR/5jOsH3yjyNcpEM8N+oddiw5jfnJgEkgy9ftMhO1u2X?=
 =?us-ascii?Q?F5W2T6HtBm3+wvcxmUzsjmTIHIOJn6bv88Ds0gAZO9IRHkpXe1qm4P4f40n/?=
 =?us-ascii?Q?n2cm5wETRCryVv3CV1odgjJ+s44f5/HTadoIcc/Yg+gFcOT+05ZksX2odTcZ?=
 =?us-ascii?Q?MfBO23Kx9vb2o6TKPRtmAjaR273PIEUfSVmVKvHQzDvM4QkcxNie955XPAsa?=
 =?us-ascii?Q?7vzn6lCtbXfVy7XRiprBBIat0Vucc3HASHf0sCr4SF6O6a15+LkX+Zqz4lmL?=
 =?us-ascii?Q?RosYknfM2HkbTci5qAy7VXTNNTnWhiBSNrmZqeparMoiSuB3lvge+IqSXSjT?=
 =?us-ascii?Q?HagMP5UI9H9RJKmPI4eUWuUyem4zsHURcbxxOa9LpN70ygh7Lly5vQ9f95u6?=
 =?us-ascii?Q?QAaqPkDF0ZoGJVWwRn4wPd0jLQQM5atL3z6CQIbMGv5fVfQ8HxG5F2qpIh2+?=
 =?us-ascii?Q?Z+r20U01z1QYP3bm94tUUGNe2Y+bKbZwCcp3hLQ5lv2L61/3IH3uC5BsU33N?=
 =?us-ascii?Q?BVAAm84LN9m5tU0zXX/b2k/vaRCD68g1bgS/R7GrLXZgqNAd54buNPfjBXmS?=
 =?us-ascii?Q?yMy18ePOzTy8HuBRyog6XKhg1QqjY3xXwmuE8FyL++DJLSaW67SEzzIw5mCC?=
 =?us-ascii?Q?srgihrgBxZozJUeFFkhqXsLhu/v0Si6SzI1en5lxDM4qJ6EyJFL4ncwp1e5R?=
 =?us-ascii?Q?Wv7KdNK91SOa2+/r23Vm06WqFxr4WSIBsftdB34n7Jgdj5x28su9NUvMeBeo?=
 =?us-ascii?Q?FgTvpiUKoUZ9Sk0DB26Eh/UglVhUaBqF3E3qATKGx/tZszZYj3JLRlw/tap8?=
 =?us-ascii?Q?nNamfekHZkSLAMskHiZubixCNPH/DiurNAUxlOZGIITM89aGjswsef0uuJ7S?=
 =?us-ascii?Q?bSSuZqJ6XRIMRD6RodzDd09MLH8sox8S4I7Z+DjpjiAPqUqsjL7ZcU/hdm7J?=
 =?us-ascii?Q?Q2WG98xQD/8dHIDDqUx9hL78YHeYWyjj7OoRvm/fOGD6unMFED5vKS+AUuaB?=
 =?us-ascii?Q?BKj6u4K+huUPDcM7qDI70+4gViPS9qy3yV+in1ISw2GMKmGpKiG1DDFQekrx?=
 =?us-ascii?Q?ymStM7aJTCLLslJs4nA=3D?=
Content-Type: multipart/mixed;
 boundary="_002_CY8PR12MB7415814E1314E87EA7F1D23C94F82CY8PR12MB7415namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7415.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afca20c-c73d-4b84-078b-08dc84b64739
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 16:49:19.3308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnyY9QyVxcCjqB5txfvtIX3wnvxZN2O5pRaSnynLMwOhJsWWqhTt8/V3SIzLHWHcQOmgJWBVYrDgI3MV6d5xww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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

--_002_CY8PR12MB7415814E1314E87EA7F1D23C94F82CY8PR12MB7415namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Tested-by: George Zhang <George.zhang@amd.com>

Thanks,
George
-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, June 4, 2024 11:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Mahfooz, Hamza <Hamza.M=
ahfooz@amd.com>; Zhang, George <George.Zhang@amd.com>; Arnd Bergmann <arnd@=
arndb.de>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Su=
npeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: use pre-allocated temp structure for boun=
ding box

This mirrors what the driver does for older DCN generations.

Should fix:

BUG: sleeping function called from invalid context at include/linux/sched/m=
m.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u=
64:8
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAM=
ING WIFI II, BIOS 4204 02/24/2022
Workqueue: events_unbound async_run_entry_fn

Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configurat=
ion_options structures")
Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++-----
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 +++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index d0ed01ac460d..d843933ad731 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1444,6 +1444,7 @@ struct dc {
        } scratch;

        struct dml2_configuration_options dml2_options;
+       struct dml2_configuration_options dml2_tmp;
        enum dc_acpi_cm_power_state power_state;

 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 0f11d7c8791c..7a8aa9396dea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struc=
t dc_state *context,

 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_para=
ms *bw_params)
 {
-       struct dml2_configuration_options *dml2_opt;
+       struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;

-       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), G=
FP_KERNEL);
-       if (!dml2_opt)
-               return;
+       memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));

        DC_FP_START();

@@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct dc *d=
c, struct clk_bw_params *bw

        DC_FP_END();

-       kfree(dml2_opt);
+       memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }

 static struct resource_funcs dcn32_res_pool_funcs =3D {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 07ca6f58447d..ef30e8632607 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs =3D {

 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_par=
ams *bw_params)
 {
-       struct dml2_configuration_options *dml2_opt;
+       struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;

-       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), G=
FP_KERNEL);
-       if (!dml2_opt)
-               return;
+       memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));

        DC_FP_START();

@@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct dc *=
dc, struct clk_bw_params *b

        DC_FP_END();

-       kfree(dml2_opt);
+       memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }

 static struct resource_funcs dcn321_res_pool_funcs =3D {
--
2.45.1


--_002_CY8PR12MB7415814E1314E87EA7F1D23C94F82CY8PR12MB7415namp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Tue, 04 Jun 2024 16:49:18 GMT";
	modification-date="Tue, 04 Jun 2024 16:49:19 GMT"

Received: from LV2PR12MB5872.namprd12.prod.outlook.com (::1) by
 CY8PR12MB7415.namprd12.prod.outlook.com with HTTPS; Tue, 4 Jun 2024 06:52:25
 +0000
Received: from MN2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:208:23e::27)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 06:52:22 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::3e) by MN2PR14CA0022.outlook.office365.com
 (2603:10b6:208:23e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Tue, 4 Jun 2024 06:52:22 +0000
Received: from gabe.freedesktop.org (131.252.210.177) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Tue, 4 Jun 2024 06:52:21 +0000
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4342C10E42A;
	Tue,  4 Jun 2024 06:52:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B5F10E42A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 06:52:14 +0000 (UTC)
Received: from PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 06:52:11 +0000
Received: from PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::4b6a:bc87:9417:b30c]) by PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::4b6a:bc87:9417:b30c%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 06:52:11 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Tim"
	<Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
Thread-Topic: [PATCH] drm/amdgpu: replace int with unsigned int for
 imu_v12_0.c
Thread-Index: AQHatXszvdNW9bsNjUaleNKtw9bdv7G1rB0AgAAO8KCAACdfgIABBKvA
Sender: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
Date: Tue, 4 Jun 2024 06:52:10 +0000
Message-ID:  <PH0PR12MB5402B2364C9D2F5095CBE0E894F82@PH0PR12MB5402.namprd12.prod.outlook.com>
References: <20240603055925.353172-1-bob.zhou@amd.com>
 <643687ee-4f93-4448-8d09-c841e1ce2746@amd.com>
 <CO6PR12MB5394B8D4CCD80B551FFE43EA94FF2@CO6PR12MB5394.namprd12.prod.outlook.com>
 <faa146e9-c2cb-4831-af0a-539dac51d912@amd.com>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
In-Reply-To: <faa146e9-c2cb-4831-af0a-539dac51d912@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Exchange-Organization-AuthSource:  BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Has-Attach: 
X-Auto-Response-Suppress: All
X-MS-Exchange-Organization-Network-Message-Id:  e92b2266-1335-4e6d-c0fa-08dc8462e267
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:  MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5f9a48c3-e5da-4a48-b6aa-cc938407c8e3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD Internal
 Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-04T02:43:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
received-spf: Pass (protection.outlook.com: domain of lists.freedesktop.org
 designates 131.252.210.177 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.252.210.177;
 helo=gabe.freedesktop.org; pr=C
x-ms-exchange-organization-originalclientipaddress: 131.252.210.177
x-ms-exchange-organization-originalserveripaddress: 10.167.249.37
x-ms-exchange-crosstenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-Microsoft-Antispam-Mailbox-Delivery:  ucf:1;jmr:0;auth:0;dest:C;OFR:CustomRules;ENG:(910001)(944506478)(944626604)(920097)(930097)(140003);
X-Microsoft-Antispam-Message-Info:  =?utf-8?B?bkljenRFRmJYcUhEd3RnMWh1VUk1bGptTUlrWVBBdUNBaTFtR1VheGw4bDhp?=
 =?utf-8?B?QlF3V1BhcjdXMGNZZ2hxeVpXb0xtU2dCUjBMdmRRNUkzMjRPMlBiUVpwZ1Rx?=
 =?utf-8?B?Nm8wTW1Ud2xLemFnRUExNXZSMEcrZ21oVkgvdDJzQldwTEJvSTFGZXFlU1pQ?=
 =?utf-8?B?R3RpOWd5RDBGM3JZa0RYR25NKzA0V3U5LytZYnJmRzNwWUJ5ejJ1REVydG03?=
 =?utf-8?B?TXd5WnRhb3dsYmdUWWh2MFc1SHR5aWFRN2s1VTJMYVNSY0d4emJwMmRSMFRD?=
 =?utf-8?B?U2hua1kyOFVCcEhDUlVLdjcwVUMrUlFlN3pqNDZBSFJWNStlcUY0NUZEVlF1?=
 =?utf-8?B?TVNwdU1ic3JEZ0E3MDVMTFhUSnBQOTNVM2NUdGRoNFJSVnhQQ2t2eG1EVWVZ?=
 =?utf-8?B?bGt6UnI2UGdpKzFxRkIzMEwyMkJEV2xsVkhZakpILys2ejlqRTNuU1FwcXNB?=
 =?utf-8?B?dUd3YlpUakd0MlB4NEwzS01lU3ZjTjc1dkdsb2lIN1ZWenlHZjh2OFV4T2Jq?=
 =?utf-8?B?Qmw2TlBLdVZKazR4QW1VMjRObk41K0l5SCtwVmhhMXZuVnB4bjJjMGd1VmY0?=
 =?utf-8?B?SGphN1RPT0lRUzRxNCt4bnZnQllCT0pkN0ZST0tNVDV4Y0FyblZkcGRRREpH?=
 =?utf-8?B?dEluVXVLRTdGYkk1N1VhbERCUCtaenpZMXAzR0FrenpSaXlPaWV0RThVa0Z2?=
 =?utf-8?B?NTZDc0krelFuM3BOcy9ZL2NzU0NpamJLKzI3NFpHa2FMTFdFRTB3VUFaRmxX?=
 =?utf-8?B?R2lZbnE1MEFFYlJWazBLbHIwVFVtR3NkcFE1L0JtakxVaW1GMTljZ3RHMVcx?=
 =?utf-8?B?ZkVta24veTl6WGNSZjZoOEQ0WDJGWGdkbys5c014bG4wRUFxcDZpS1VUbng4?=
 =?utf-8?B?Rkp5WVdBY3YrcTdQc2h6a3M3MEFkR29yTmloWXc1VUZ4ZzBTZlZlTlRkRWNP?=
 =?utf-8?B?R3hqL0U1MUh4YktTL0FvWFVZT01nWFdic0VpWGw0bDBmcnhWVVZKNCtqQ2Jw?=
 =?utf-8?B?OFcvNU1PL1hYRGJaWkc4eDRkN3pOcDVPem9pMWxDNmxFcTVRa1pNWXBsUmVr?=
 =?utf-8?B?TXVBUG5uODY3dk81NVcwUE5aZWZDUk5mdEJLS0RBRWNvdlpVM2tvZmhXZStG?=
 =?utf-8?B?cFNkQjBSOGpXb3NQS2M2NzJLNlh5eHdvdUFVKzhBRGJRRHdNd0RzNjh3cmV1?=
 =?utf-8?B?V2JmTWRhaUEzbElTdjFiUGNBTDdRd09zR3F4UU1CTEZCT3ZBdk5pZ0pEWHhD?=
 =?utf-8?B?b1Y2aDlLOEhkR1AxRVNBbk82Z2lYRmh4Q2l2cG9Sc3lQVUNjbWxjaXBtZElQ?=
 =?utf-8?B?OWJRNVUrNzJoQ1Y3U25KMnhSYTdZV1Nuc2FVMFVHd0dkTW5lYmxha3YvaUVt?=
 =?utf-8?B?UHczVTN2OGtORk1mVU11WjVQd0V6SGJoOHJ6WUh6OFhuRm82NUtYUFpJWXBi?=
 =?utf-8?B?K0VpK2FNNHI1VnlyMVpWWnNobEdyVW9NNjI0TFllOWdLRWs2RTNtNmxlWUdr?=
 =?utf-8?B?VGgxYkh0b3FXMHNZaWNDaHpKQkJLRDJ2TVhjdVd4bXo5dzFaNmM3TE5vczFN?=
 =?utf-8?B?UmNEWEFhR1dORllIQzdmQnhmK0x2WSttVW9wTmd3YnNKNU9QYmlqZkk0T1V6?=
 =?utf-8?B?Sk84KzNja3ljQU9ZdGFXUTZrNW9ZN3BFUFMrT1ZWMzFPSGZDZHRRWEhqZHdP?=
 =?utf-8?B?U0FVdStLQURLUFdLdUtHbU9Kd2FWa1VzejIrOTdFbUFQQTFIeXFEWnEwWjJE?=
 =?utf-8?B?ZDA5S0xIV08zR0R1dmdLTFQ5T3JXVkhuUTFHUXdhdE95U0tTdCtnSEFBalVq?=
 =?utf-8?B?OTdkSVFGQmY2QVVQOWw1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF866EA5153B034F8A5B769FF2092717@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25s
eV0NCg0KSGkgQ2hyaXN0aWFuLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIHRoZSBSUkVH
MzJfU09DMTUoKSBtYWNybyBzaG91bGQgcmV0dXJuIHRoZSAzMmJpdCB3aWRlIHZhbHVlIHNvIGl0
IGNvdWxkbid0IG5lZWQgdGhlIG1hc2suDQpBbmQgSSB3aWxsIHNlbmQgb3V0IHYyIHBhdGNoIHRv
IG1vZGlmeSB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIHVzZSB1aW50MzJfdCBvciB1MzIgaW5zdGVh
ZCAuDQoNClJlZ2FyZHMsDQpCb2INCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiAyMDI0
5bm0NuaciDPml6UgMTk6MTENClRvOiBaaG91LCBCb2IgPEJvYi5aaG91QGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFtZC5jb20+
OyBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCkNjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiByZXBsYWNlIGludCB3aXRoIHVuc2lnbmVkIGludCBmb3IgaW11X3YxMl8w
LmMNCg0KQW0gMDMuMDYuMjQgdW0gMTA6NTMgc2NocmllYiBaaG91LCBCb2I6DQo+IFtBTUQgT2Zm
aWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+IEhp
IENocmlzdGlhbiwNCj4NCj4gSXQgZml4ZXMgYSBwb3RlbnRpYWwgT3ZlcmZsb3dlZCBjb25zdGFu
dCAoSU5URUdFUl9PVkVSRkxPVykgd2FybmluZyByZXBvcnRlZCBieSBDb3Zlcml0eS4NCg0KWW91
IG5lZWQgdG8gbWVudGlvbiB0aGF0IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KQW5kIEkgaGF2
ZW4ndCBjaGVja2VkIHRoZSBoYXJkd2FyZSBkb2NzLCBidXQgaXQgY2FuIGJlIHRoYXQgdGhpcyBp
c24ndCB0aGUgcmlnaHQgc29sdXRpb24gZm9yIHRoZSB3YXJuaW5nLiBJbnN0ZWFkIHlvdSBzaG91
bGQgcHJvYmFibHkgdXNlIHRoZQ0KUlJFRzMyX1NPQzE1KCkgbWFjcm8gd2l0aCBhIG1hc2sgd2hp
Y2ggb25seSBsZWF2ZXMgdGhlIHZhbGlkIGJpdHMgYXJvdW5kLg0KDQpPbmx5IHdoZW4gdGhlIHJl
Z2lzdGVyIGlzIHJlYWxseSAzMmJpdCB3aWRlIHlvdSBuZWVkIGFuIHVuc2lnbmVkIGRhdGF0eXBl
IGFuZCBpZiB0aGF0IGlzIHRoZSBjYXNlIEkgc3VnZ2VzdCB0byB1c2UgZWl0aGVyIHVpbnQzMl90
IG9yIHUzMiBpbnN0ZWFkLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFJlZ2FyZHMs
DQo+IEJvYg0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiAyMDI05bm0Nuac
iDPml6UgMTU6NTYNCj4gVG86IFpob3UsIEJvYiA8Qm9iLlpob3VAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT47
IFpoYW5nLCBKZXNzZShKaWUpDQo+IDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiByZXBsYWNlIGludCB3aXRoIHVuc2lnbmVkIGludCBmb3INCj4g
aW11X3YxMl8wLmMNCj4NCj4gQW0gMDMuMDYuMjQgdW0gMDc6NTkgc2NocmllYiBCb2IgWmhvdToN
Cj4+IFRoZSByZXR1cm4gdmFsdWUgb2YgUlJFRzMyX1NPQzE1IGlzIHVuc2lnbmVkIGludCwgc28g
bW9kaWZ5IHZhcmlhYmxlIHRvIHVuc2lnbmVkLg0KPiBBbmQgd2h5IGlzIHRoYXQgYW4gaW1wcm92
ZW1lbnQ/DQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEJvYiBaaG91IDxib2IuemhvdUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9pbXVfdjEyXzAuYyB8IDYgKysrLS0tDQo+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pbXVfdjEyXzAuYw0KPj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9pbXVfdjEyXzAuYw0KPj4gaW5kZXggMGM4ZWY5MDhkMTEyLi4yZDZmNzU0
OWMyYWYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pbXVfdjEy
XzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaW11X3YxMl8wLmMNCj4+
IEBAIC0xMTksNyArMTE5LDcgQEAgc3RhdGljIGludCBpbXVfdjEyXzBfbG9hZF9taWNyb2NvZGUo
c3RydWN0DQo+PiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4NCj4+ICAgIHN0YXRpYyBpbnQgaW11
X3YxMl8wX3dhaXRfZm9yX3Jlc2V0X3N0YXR1cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikN
Cj4+ICAgIHsNCj4+IC0gICAgIGludCBpLCBpbXVfcmVnX3ZhbCA9IDA7DQo+PiArICAgICB1bnNp
Z25lZCBpbnQgaSwgaW11X3JlZ192YWwgPSAwOw0KPj4NCj4+ICAgICAgICBmb3IgKGkgPSAwOyBp
IDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsNCj4+ICAgICAgICAgICAgICAgIGltdV9yZWdf
dmFsID0gUlJFRzMyX1NPQzE1KEdDLCAwLA0KPj4gcmVnR0ZYX0lNVV9HRlhfUkVTRVRfQ1RSTCk7
IEBADQo+PiAtMTM4LDcgKzEzOCw3IEBAIHN0YXRpYyBpbnQgaW11X3YxMl8wX3dhaXRfZm9yX3Jl
c2V0X3N0YXR1cyhzdHJ1Y3QNCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pg0KPj4gICAgc3Rh
dGljIHZvaWQgaW11X3YxMl8wX3NldHVwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4g
ICAgew0KPj4gLSAgICAgaW50IGltdV9yZWdfdmFsOw0KPj4gKyAgICAgdW5zaWduZWQgaW50IGlt
dV9yZWdfdmFsOw0KPj4NCj4+ICAgICAgICBXUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0dGWF9JTVVf
QzJQTVNHX0FDQ0VTU19DVFJMMCwgMHhmZmZmZmYpOw0KPj4gICAgICAgIFdSRUczMl9TT0MxNShH
QywgMCwgcmVnR0ZYX0lNVV9DMlBNU0dfQUNDRVNTX0NUUkwxLCAweGZmZmYpOw0KPj4gQEANCj4+
IC0xNTcsNyArMTU3LDcgQEAgc3RhdGljIHZvaWQgaW11X3YxMl8wX3NldHVwKHN0cnVjdCBhbWRn
cHVfZGV2aWNlDQo+PiAqYWRldikNCj4+DQo+PiAgICBzdGF0aWMgaW50IGltdV92MTJfMF9zdGFy
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgIHsNCj4+IC0gICAgIGludCBpbXVf
cmVnX3ZhbDsNCj4+ICsgICAgIHVuc2lnbmVkIGludCBpbXVfcmVnX3ZhbDsNCj4+DQo+PiAgICAg
ICAgaW11X3JlZ192YWwgPSBSUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0dGWF9JTVVfQ09SRV9DVFJM
KTsNCj4+ICAgICAgICBpbXVfcmVnX3ZhbCAmPSAweGZmZmZmZmZlOw0KDQo=

--_002_CY8PR12MB7415814E1314E87EA7F1D23C94F82CY8PR12MB7415namp_--
