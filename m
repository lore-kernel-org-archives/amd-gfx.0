Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CDAC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 19:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB5B112E42;
	Tue, 30 Apr 2024 19:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xZxi8e4m";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDEA9112E42
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 19:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuCMjzQ9aYXuxGBgWrGofpAalHP2JgceK5LEgWuFweo7tiXaYpn13hZL5j8LtHgdg1Pi0yFJvfD45cQrdsUcgdhmmrUHAaj/xNepceDPAuDaaPnnxNHJ2FccpEb7zvoTDZbOYQ8vM578rXTq4MKMsG5eoCj1D3MfLUBh0nEsMkGj6LZMCa3+Uh0xZCTZpAwuxruwzrff2teYL0yr/nV2vokxav8uWU3EEXVBJrvDRTYmOvDiYi4CXI5uj6U9qzGzhDRPRgAnPQwhWTd96i9OiRwMnGGlAw0Y8I0Eoo+GS6b5/UC4r/0ZvMPjEaDzdWTiqU2o0pJFlGt2RuHnZIoLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B4dJYxER3vEUTPamdgqK5xLRHkTYHHOmyq8ooGVTGg=;
 b=cDbjTIHsEQwo6OPK4Xhb7N9rI+Ean1uJnVVQKq9KpH8VpjzJeQeShAZTvIQH63Epv/KY24XhTNh1tn5sD/awNhT0YSCwiBAe1e4Zx3bUR/CFbMzLRDWLu7m5bJcuNBf5yiBMws2loFRdtSRN4VQ2e63xsitUD0CHml1YxKw/dRYkRAxd6WULhS5z9Blapk6akWeyhWCKHfwqljIeuoR0velOhFFg71eheJJSXXHJqKmvnHkM2nKNYkoChORW6WpHb/nXc9dw53fdTI8nn9Xabo3+Ebw4qxGtS8z++MfLoetFJU0r8cULusoMcg8e7W84+lo4PTXvmSbOEBK/KSM5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B4dJYxER3vEUTPamdgqK5xLRHkTYHHOmyq8ooGVTGg=;
 b=xZxi8e4mFOQGut+g50S0VxpTZncABT/5ruEEbe7jQeL8PF39S71wMreRN1m8BIBmYn5swtbv7oKl0TjjW46HHRVDgZfSmf7Yhx32hIOj5uPg5WlWeAiFwtSrumgwHQ4DY6ysaWyBsLg5iIKBhSU5PvHtvCM5UjRZM+gYNxAMuJM=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 19:05:16 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 19:05:16 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH v3 1/4] drm/amdgpu: Fix two reset triggered in a row
Thread-Topic: [PATCH v3 1/4] drm/amdgpu: Fix two reset triggered in a row
Thread-Index: AQHal44To7svfRz5XE24ZA15k4x/6bGBMVNQ
Date: Tue, 30 Apr 2024 19:05:16 +0000
Message-ID: <SA1PR12MB859947EDEDBA9CD73AA1271CED1A2@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
In-Reply-To: <20240426035742.90560-1-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9b862869-bb22-4449-9c90-9074fc1e4d98;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-30T18:57:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|MN6PR12MB8516:EE_
x-ms-office365-filtering-correlation-id: 5b9b5635-772f-4220-7561-08dc694878bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+2KyiTH3DkRTITc+NnPKsK3BMil8ENm1a6aM9offltjF3Q7h88buSOS8uTbN?=
 =?us-ascii?Q?im173XjY9EVj8oKRbnx/6F0UO9WyhzGtkGKsD9pXGom7fZZw6i/GLQdknccL?=
 =?us-ascii?Q?+CPk4bcVOaD+akBdftFUERmoggg6i1oXZjtfvUb6LaIibdBMv8FmHsM+O8zL?=
 =?us-ascii?Q?wLk5oWed0yIhfIpmsfkxWLYBj1Gly8vmOBFTzVnt6SL/1/7hDPzkdZtVWpNu?=
 =?us-ascii?Q?2BGrYlquw0QGgkszK5Jx3CdTFsI+ObHpqhFawAJErJR1N2HZTr7oTpJXlPXF?=
 =?us-ascii?Q?5Jnq6IMSgOmGWPXSvJvDIraYQdrYRDWyZ3Emtlje9z24aMS7nQ86q2U8lz5K?=
 =?us-ascii?Q?cCMew9n9WlxAG1gqUi2F0N459Irq5mzEbz6+2Ha08VCnJaQulJro0jcx1ply?=
 =?us-ascii?Q?XtBlvDU9qmI/6toB8WGC8Uxh2vg3Ocsvr/Fjzg2l2EeuIPZgVyeZJaahcHSb?=
 =?us-ascii?Q?ATf4bQYG+xoKciPiX6q2LSzQkxZOWkOUSykdxLSe70nA6pYUnYeoB+LpBlig?=
 =?us-ascii?Q?Rv816I3bgy3J1b4f8JmnhUA+g51jpg2WUT5lebuLVhUxXtdAufMjmgn+nP7f?=
 =?us-ascii?Q?IkPQxt92vxYIx5Ro7Cb4I4lnZDNf0Vw0HJYSXqqe5Mw+yB1LSQp23497jLT+?=
 =?us-ascii?Q?zeMuwSachpdl0EFdDXUJ5HKdZratutyDOkx8nuiFxc247oOITbbUuYfK2EuM?=
 =?us-ascii?Q?dLdGOUAdlzhuxrSgFP5ZDH/9WaHLcIQsL7sodR3sRtV/6dNGOQq0XPX1kWiD?=
 =?us-ascii?Q?rI6T4aiVSa6bnrO6q9cFIDe+ayIvF9UsfKV5zmxAyLdgMDAOWkqKhEb8evAM?=
 =?us-ascii?Q?rC1My0iVWQp7wYeezUKdcxtbjUTXPYE+D6s0oDhZ+KKIZd5q964N1uZp0qXi?=
 =?us-ascii?Q?Um3m1FXuRzZ3zg9NR6QA+y/K7qDpQhlVPcy5NjjPuYqVKxx3DSKnOT4j7Lmn?=
 =?us-ascii?Q?2G4KkQe07n0L0kZrli/W5vlG802pwH42Urvwu1R0F3hXAQk2thuMBbdkIewH?=
 =?us-ascii?Q?fTLO+CqB6L4RrumRg+EweOfxSY3Ex3gLPLrBYhbZB3D89tSGqDTc2rxkHCQi?=
 =?us-ascii?Q?+horgF7+TngQGDoQgzcOoU07fs/C+xMGrEEVlrkR3OgrlETuHqn8e1Bp0leD?=
 =?us-ascii?Q?xy7nDnEw6QWgZBDdQG0kmm387HexGjt+GeO/9yjVdPxsQesev3bL79p3iSj8?=
 =?us-ascii?Q?RmzGqsPbiYJ/yMxYzSjZQ5R5E5LyJ8Q9oagJjIaec54iLK7l1muDT7Ku4BqG?=
 =?us-ascii?Q?uQCTNrOE3uXMcduk8EKFUNM8DIA9e19aEFe8RN/ycw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s4voMX18kVUyAnSnyIL63aKJHsjn3makHhRZ2ZLiBUEQoOcHA69+znIhOWfN?=
 =?us-ascii?Q?wvegLXbvnTzyJvgk5JW0s+QPBGpbt+OzLh4n/goj+XdJYFt6irG2RcNEBSK5?=
 =?us-ascii?Q?2YSr7YVKEzPmb6GSB2UT1FwW2oUwB6W7uds9fTKaJmmE/BaKQ+OboF7OsFrn?=
 =?us-ascii?Q?5g9JDhVTbos7MubGmTaMqTr3cnyJ6Qlo3RPKvwOc9GBkHGC5d2F35GKQs37d?=
 =?us-ascii?Q?5WYX4KznbzPA8Ik4F71zzErJtMPZGh328SCLJVrOjc3uTtxmYDMDRo39md94?=
 =?us-ascii?Q?zQlwSZMLU8VoyhviQb5GGVTMEuME//FlbJzDa4dug6SUzXsSnCz1UhM0d6v4?=
 =?us-ascii?Q?2jBVH6Htzg7sA5m2/Lny6VqBuxHMbH01NPrDwSWNDmDLNYnCuOF4A/L5ugTz?=
 =?us-ascii?Q?yQ1R4keRFhElpv8ZDIKcZqTs8yevA7YZW6+sJ1snCBQZvT4rt9fbLap1UrqP?=
 =?us-ascii?Q?+ZloTpC+RDMOwlH76TREbZ1X3WrdrqfI07UWOru+1u0QwBuqUfY1mLgp2kxl?=
 =?us-ascii?Q?OdVcFxiuj/gyA/lmVo5KaiahVFZ+p7mGDOKV4JcXTZ6VIAS+j2ITphF5yW6Y?=
 =?us-ascii?Q?NR7gwrIcdjzz0L5jT7hfMlanOmKEqZARMhPxsWNApIUDbg2yIcQ8JnJ+LIfi?=
 =?us-ascii?Q?Z3RQugcK/eg6miWGWVY5KFjuIG2BgYuL/lVdt9bXLyeEykUWYcAhhIIaEgpk?=
 =?us-ascii?Q?9iFsNb1Vna5VbYSDoZaj4Z/GC7WF5qhkRWGx4kmqy/jalOqzuSui158VPVOE?=
 =?us-ascii?Q?9yZcYI9JgCW2qUDS8L00DIOUlVvOQNCWguWDPT5O7PPpkyj4uiEjDZLlyIGB?=
 =?us-ascii?Q?HgLO/+c7FohkgvqVE862Meryv6DTNapkJ+WufQlbwp3gQuUjUwZeFR5h44UR?=
 =?us-ascii?Q?xtJhMSdw4w6mrJntG+WjJYV4E7VC+1r+IkLvNUuEJsY8gu2G8LvxduE2X+ts?=
 =?us-ascii?Q?1ySb+S2z9BcW7og5C3gLqEInbLcgtc3Puarrv52qZOUqXOL8xjqcSMDLE0x/?=
 =?us-ascii?Q?OttKyTtgvrwXlMqyvlT69/roQCExTty0pJQgH5eL5YkMSD2BDhpK7qWQji+P?=
 =?us-ascii?Q?HvdTdAddTPLrPkRLP+qcHtKkyGFYL9rOYuuPZgzLvxArDyLnRmLniuEXxg7p?=
 =?us-ascii?Q?j9rBA5XwD7r5kHEgmz1dRETEhrOCxpl3Ar8OjYhaQbuwFKyN2EjJz3KOT2EJ?=
 =?us-ascii?Q?s2orXPFoPGWWgNw/eK4Cg4YzL4o9VmHMo6kmKEneH5Se7YfhPnUGni9Cofga?=
 =?us-ascii?Q?Cy7yxIog/ry7Wrgx7GjMAdlfhwVmQ3mPb2YB00n0rvgXFQfxmTRmUZcMqnu2?=
 =?us-ascii?Q?whs+294VSxG/zhSypVE0RSWk+H/0XZnXyZxBK2vzyqJsrm3+4Q8X/30e9jwd?=
 =?us-ascii?Q?Z2C+mCS+SFJCFPeBw1+uOWtfVezN/1lDhZi+72NJNshr8KqnV4NUxn25SiTN?=
 =?us-ascii?Q?r+jtoEjrToNUJCkppzlRUDgttS0HjkaJcEx2F7pf8cJ4zOWMM2Znd0F23wfS?=
 =?us-ascii?Q?VtxnNxWEtYazCoVvVNpweEJ7Xt+809gxULT1qddmuqRkiDotRYTPdsjl83MA?=
 =?us-ascii?Q?6koSnZDoEad1s9TosBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9b5635-772f-4220-7561-08dc694878bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 19:05:16.3924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4vgWJLhoSBroDIi4DItiQ6NscOh7WP3Ob4QfoZaqtmWMptqHCKk3oo3Qz3+2g2GbAkPyF/vvtajU9YXBnFPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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

Hi Christ,

I got R-b from the SRIOV team for the rest of the patches, can you help rev=
iew this last one? I think the concerns from the previous thread are all ad=
dressed https://patchwork.freedesktop.org/patch/590678/?series=3D132727

Regards,
Teddy
