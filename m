Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85143C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 07:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389AA23A6A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 07:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389AA23A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8746E093;
	Tue,  8 Dec 2020 07:03:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E026E093
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 07:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcbdTlpF+BzuJlw3j24VJV0DKpoBuKWX1e9E3X3p40vDNalXx9XKa1hHRHtWJgDx810n04vdfwGm0Zp7WIl7zBT9j1VPkGJ39UEAQXAUD1hXUvf7peHoCJuw1ZHMlUNXGh5awlfmGVQhwX89VD8uApUb0EmYQJGBJ8cnbpY7lfkq24Uzz2XeIYXKAckApETD39s52F5uXg1x2dqBf/bU/3/RCkII5dvs5Z1uL9h4jZlKGM41R1tHFoHip47KNW2o7OcHLZWRAk6sLtBbiVQCJTdg0togTizfrT3HzWankm1pEYUDFNB/vAh8ifZEJnripk9MIeJELQmD8PVH04PoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn4ScPGRvuE4NgV2w/O4W4O9+03WO6YCjmX2/K/aGHU=;
 b=jieuf2A5L/voTzIx2trmdUdUACOsikXF3NhyDUYA1EKFFpkfnAEn6REnjAQPG6afSw+SeKVEeDyx5czbWVkzXlPR96/xhnkhT05Ds+RErlDX2LmvOfoUuVa9qJtLJ45oLNBBnIim1I7zMGxETrGooKTaeBJdSpvL5umpAMvlsWxprHK3TLqiJAznL2YgHSaaVq2QEYmJaV3f28rK0Bqy7nzGLgCt7w9a885wcqkvSDZrlHLh3yR/C6cD5LXB7lZ2wC6yQNHfJJ2pKUrfBvHTex+uTMOy6Hp7E7Z/KsH4PC6HU+wq5qeGzUfyeMFeMUY/JKpc0x9Wch6oEYVKtdUxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn4ScPGRvuE4NgV2w/O4W4O9+03WO6YCjmX2/K/aGHU=;
 b=CeA8ldj2jhUTCTS2hu6em8QnARdifEhq7Co0yCJumlQL8wEhlHE/EZ4Eb36yJrHyVBEuby9L5NTvX8jAVjTz+XrlCMMoq6io/T7rAlBZplWpKDGTacO+ozLomIUD/1OnouG+fRJGEC6E44JxasHxU4Cy4jl7IlpZXa3/WuYS3VU=
Received: from CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 07:03:26 +0000
Received: from CH2PR12MB4940.namprd12.prod.outlook.com
 ([fe80::350b:2673:2db7:8696]) by CH2PR12MB4940.namprd12.prod.outlook.com
 ([fe80::350b:2673:2db7:8696%9]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 07:03:26 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Recall: [PATCH 6/8] drm/amd/pm: add yellow_carp_ppt implementation(V3)
Thread-Topic: [PATCH 6/8] drm/amd/pm: add yellow_carp_ppt implementation(V3)
Thread-Index: AQHWzTA5gbqgMXDHKUqoz+kopJ5Mwg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Tue, 8 Dec 2020 07:03:26 +0000
Message-ID: <CH2PR12MB494057A1F50280A41EB6F6A5F0CD0@CH2PR12MB4940.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa6d3f22-d9b0-4d68-1e19-08d89b475c5c
x-ms-traffictypediagnostic: CH2PR12MB4229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4229175ADE1B7C7D139115D3F0CD0@CH2PR12MB4229.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dxFaF7rbZQIGb8cg74ZpUOa8g9wR/yDu63JnEuvvzkNBu6+m9mg/eiQSL/4ja6/6jSg5hf94p8P+SwrdzwdyGg6Je6O75NhxVbGVA3bFGeBDQBBwygcSsH5uiVQN3gDv+MwIiBIUeJj6ckFm6Ny7Ug15IhL6RTl42Ns4tPvchjqu82XuNZw8YiIxzS2qh68tct3MBvpBOIixviOhKI3PbbjhxDBB8ivtRlt9kWxKe+1LOR06by2rQx5pDlMKMh9FqQ9lPxiM95KP5D+tTXPlhXP/wNMQ7yogHzY1dM+IEqwjo+PE9YNCIfRNfHSPq5nhdXn1n4fQHDVHOaJOOTP8aA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4940.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(5660300002)(54906003)(2906002)(26005)(55016002)(6506007)(4326008)(478600001)(9686003)(186003)(8676002)(71200400001)(8936002)(86362001)(64756008)(66476007)(6916009)(33656002)(7696005)(66446008)(52536014)(316002)(66946007)(76116006)(83380400001)(66556008)(558084003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YMPSTEjDX5ApnIH/G6iJJvBfnEHFES15n70wQfQjUtJS/VIcBDhdIVxeQWAT?=
 =?us-ascii?Q?0FbIe+cjAdILMA4nAIgGdiJVN/pgyzna44Y60i/JJtEmQXsIZrqd9QKlnuoo?=
 =?us-ascii?Q?BfkQvo/QmUO0WV23QnwGpz3DpbvfxWu4Tjlt6SBzRw9N28rjVtKHphVCKF/c?=
 =?us-ascii?Q?7BXmsKIvCYyCGPWLAHyv5etmGfVUSj5AUkKkGySK2hIvmpXSOLSzaWomF6k4?=
 =?us-ascii?Q?9WOtoQGFCEj4Ph+sMl7SFF9FfIJR3/3bZi4J7ELfIOKJVNWRKCKF93W/B6sJ?=
 =?us-ascii?Q?gThhzo18qFuaC6lInWlDZ7zPjQ6Pjuf5HgCM0TQ1SlEXPRT7Lz28RuF7U3ys?=
 =?us-ascii?Q?tnlSXjuWkNrz+5RELEtoqhJaLFflCXGqk/SIUHoT+FTYYJ1howCXDqVz4QCL?=
 =?us-ascii?Q?fMOUGGo3eyzh2vCzSday5iEGMS0lnNIcc/Rns+w+fuUu0NfzYt6nGReI/c0o?=
 =?us-ascii?Q?RPoMKUXxA9dSpzc8PXfITWm8pnI2qSG14N6J/cGN45UKD5ehnrzKDyC/B3U0?=
 =?us-ascii?Q?YGoim7dWOW9HBKzVcaejPsYICd8PWtd0e5a72Jg6EeVRScMvZmW2+XyWUxzv?=
 =?us-ascii?Q?+BA//cHL3LQGsVefjXGFY5fKTxQJmfJ9zKR2wjc3wrqE1lVr5xLiabc8KswT?=
 =?us-ascii?Q?3MPHY49ZEzAncIRhSu8LlxuCWH464GKyJg0x+nz4ijaMs5ThEAtmSCHZwdXE?=
 =?us-ascii?Q?vBo/uECizWptR1UkKkU4N+2UTR09v5q0Aj0c7vnQx2N2EJKpaWYJh4XxqZnW?=
 =?us-ascii?Q?OnH3XQjGBr1dYVoGAU6C0T6Vd7/BNwj2qbLWL0j853fBZTsReuFM1/+C665p?=
 =?us-ascii?Q?oB4al5Vzc+dpAiZRUOD08UguaiB+UdtDGYAnwxjyCfer84vfuD3DHVLv5k57?=
 =?us-ascii?Q?yzmMgwkZP5EBMRXkS0EBaQNbjul9PafYQ2uRyZVEgg6xd7x/FGLS980igDzb?=
 =?us-ascii?Q?M3EFxAR8VbXfoqNXkshKJIQ1zaFBcM8Tc29jnax9TQU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4940.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6d3f22-d9b0-4d68-1e19-08d89b475c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 07:03:26.6045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGzg88Cl2ASZGn6DRuE5QuFMoHCoFuYLSagKrzrUetVnLZBGpKmPOG38ScgK3M/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Liu, Aaron would like to recall the message, "[PATCH 6/8] drm/amd/pm: add yellow_carp_ppt implementation(V3)".
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
