Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A36C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jan 2022 03:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CB010E1D5;
	Sun, 30 Jan 2022 03:19:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57C310E1D5
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 03:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUvAy7G+CLVhLxP1F0G91L8QvOJ2lSQj9fLTNr78D5HQf5HLCEjpsaqJKPznWo36RA05idzQdcjArT9Ivx14kcskjtThtlp0/QCDpoG1cGSsqEAj3+AdzaQzM9bfBUMQMDLPSs9M8FLZ6lNluJi40JEuVNq7/ruheO/wqIL26yRavViwWdToS/J5adi966Gd2QifsaE5XaX3ZwE9U+NGyjRAUVzmJjL+4/OaS5w1WRkdOsKzRToB0Cj6jtJs2+aSPR3JkyPZDm2/EU6FkCkRUCAMHX0wjSyF1u+Vuq6GpVdgchX30pTGWrBpWhnQBwjNSsn5kUe/qYb0EqR/ty/7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ9crEOAQ8zC/MoI88fdD3LmVnXJnPwzA/eAppSp7rM=;
 b=PIGri/V5tQUtMc2Ze5GmGwiq4GCW/mL1cyE5CQ0bOCwk+D9BROhSvYvaJ+l6GB3LnP7fQ7f2V5ZUipSk2iVJ4WnyD4sCIWJIjwzwPF3xXn6MY3SCQmF03VexPMMTjSlpSbOvEOl0kg/TmNiFPw1Cb3clGRRCDnaOfGuqh2yU0IgXTJoUWjCyoIuWctZYHu0P00L7L8+wSHJL5NHz59CHfFoh0RpjEm/WrfxdE6gLVnjiS9NjjehVaQIGYJ/EsigFlpDol8a4fimGJ0u7SprVxuTeoeGAMd8kJMUa29g+/u86zdhI6xj3lU4FNjmNxKqz9qTWdFyLfJ0Hn72iZVOCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ9crEOAQ8zC/MoI88fdD3LmVnXJnPwzA/eAppSp7rM=;
 b=5Jf/m989pXBKwcXKgY84jKe6zAwUMQboCwvZzzxbtjsbDGRwZA0jX8Qf3H8YNc6+yG+dxgPBqyW3Xnt3lNseNJMDzSYvPms+xpmWtbCPThhlepQLtvh8gq7CpjqsJMAon6emO14Iixh6ooC65+5aSCPcfUx19uNM1f+LaVgvNoQ=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Sun, 30 Jan
 2022 03:19:30 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 03:19:30 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
 infinite loop
Thread-Topic: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
 infinite loop
Thread-Index: AQHYFQyUXmE0Jo0pSk+cIHY0e91wzqx635Fg
Date: Sun, 30 Jan 2022 03:19:30 +0000
Message-ID: <DM5PR12MB1770916E530D42230CFB4B9AB0249@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220129123352.3765260-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220129123352.3765260-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-30T02:55:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=78b4fec1-bd90-43fe-b9c2-bd7da1bd82fe;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-30T03:19:28Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 0828e023-a475-4aac-bdab-b6ad8faa87ea
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88ebb532-d3b8-46a5-ff45-08d9e39f5435
x-ms-traffictypediagnostic: DM6PR12MB3099:EE_
x-microsoft-antispam-prvs: <DM6PR12MB30993D4F1D7DCCA0A7616174B0249@DM6PR12MB3099.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QnBK6aL3zrysnpJnuE2Ravj+DTW7/TzIyJ9x+cFJFCEtnmSVHwv7ZJkViWTaFxlnONZkb3+cKfoRmf/U6WiYWGT6iQ6bXYTqdV3+NjSxAV4uIV4iuvsV9LpoI4KxkZEUzgAISbn+jXXTMstCUdOXlRVmfVG6KTo16pUPIgt7o3ikMynRtPFvy9ZdASbIYmO3dXiPJzKgzXWi9MtJEybK59TyysbJA7k5GnF9AIFUG/TA+yxOCM2G98FNzM3e7n3Kk+okddl4S0pUQwFxLICqILKv60kt7yg6DjdVJsb2uWPyvzqxeRjjs0q0tKbwW8bOPS1ezFOF534rowV4/sL6xT/HzvWfg0AX+TOq7LuDUowvYD1t6rE2GBQXbA9rlHqOhfRXoX2pKrmd5IAF9oFk+76WhzU4m2cJdEzXqQoWpC3LMRV22WkBzzFgsU1/V7IxpE7ixvpPtyAOw9GQ6gdGxjqkfH9uUuyNj3cU7i6lCjZYgdg2wmD7rrlODtMBjpbP8xNVAcVQaliiCVjkAWheoIwc5Zf2fsAQXohBBplqz5r0DnVxQPA9OeytjaRAbD+Ee1nRhg9qd+oyC+Za+XF+RLbrugZFt0RXGneRztHldi3IaaMlf9RrSIeqm5LMY7ONxlIEae9e9Nx3TBquSoGNhS1HJc4eGOaIV54wm5XLiN5Cts89LGM7EpAuB6FL7+5ND2aQLojS9xY5/gR58rOrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(64756008)(53546011)(8676002)(66556008)(26005)(76116006)(6506007)(55016003)(186003)(110136005)(66446008)(2906002)(66946007)(122000001)(508600001)(66476007)(9686003)(5660300002)(7696005)(38070700005)(86362001)(71200400001)(52536014)(4326008)(54906003)(316002)(83380400001)(33656002)(38100700002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b7FQdz2xlNWG3ogCtjQ2+7qafpWb8X5Py6P3IdXYlDuxPIygLxx+8pMlNw0F?=
 =?us-ascii?Q?K5L7CmvK6zMfjhC0HXRFWHQHDLr//sS2WPILC0IeA2LKqRer2+4ggHRFjOvr?=
 =?us-ascii?Q?YRZaQXEr+hJBm2YxBin7sVKz+843ohYS+bR50pbjfpDvkuJ2Qia1CyPE7Y/G?=
 =?us-ascii?Q?YXPALDZiGaCACnSMSAQ5rMNg8AkyDbM6YQUExZjOZdhgD55XI7K825+ZHl/Z?=
 =?us-ascii?Q?1lSjQ1SeZCRshFttd2lOoZZ3YazSh469M5Cl4AnrErVWjmJoRkWBcAPAYFnY?=
 =?us-ascii?Q?8X1paVWVFeewphwCNjXMz+3ZwFn6naN/Z40KgYcvn/XGMAbluWFF2BIBUxJh?=
 =?us-ascii?Q?kUWyNAb2u/qoS4gS9Mw3GIOj6SaCPW8Jg+PX0ipoDhIRp+ORbQKOOv5pijWP?=
 =?us-ascii?Q?oc5BaEd9zOy7nrFxQsBaPEt6sEDz5P0adKhILXUAlFUwcmaHl3mACSxuhx9b?=
 =?us-ascii?Q?JjQnFhkRaFDOzP/mQJm6b95NLHCoRyjbFSVBzhfp0grc8c3zlb4EflaM1UH2?=
 =?us-ascii?Q?mviwXJoB0737kPqCiWqTZoFa28ERCbClLQkhTMLhoOO1OMK8/ZvFnlVded2C?=
 =?us-ascii?Q?hE1gh97YPnlpBe1QoiOtaflT3+TqB+SDCRH3MJN4xKj7DbIpgJi0EphYd8vj?=
 =?us-ascii?Q?pzp27S9Pua7DDg+ZxQimbW9XR4HOOecgYJxnzm3fj0qX/KRYlX6QFcx+SU/u?=
 =?us-ascii?Q?drrpcq6chzgKf3cd34Iovvq0PdE96ulZ0dQqUUUfv/xcxb6fED4BN4o1zkok?=
 =?us-ascii?Q?qObOxHGZ/71UTR0YyiKXwVpR6vgOyBgR21u3rBlpLkMYcejSJUCrk4Td48qS?=
 =?us-ascii?Q?wJj8/gYF2VrY3daNOu+KF1If+nyFU5hA1WpOp+cW7IOLavTjvwnfBlvLyNkd?=
 =?us-ascii?Q?QR9HTnWBnqKOenu+jMRnEKQhwVq4Rc/s9ZsCRe3HyFNPlWsbMf3lTm1ME0u6?=
 =?us-ascii?Q?lkLj3M0s6XmYUs2k2O3zclqOunjht8+496uQ91QEiDwS7s9HIztpGYCTy8l8?=
 =?us-ascii?Q?UtoEvghem2BLyarwBxCMPwyIYKTR2D5pTGOjmmOPQi+pznbPlDJnuVZv1V+2?=
 =?us-ascii?Q?n0Nqe3MqUN/0Z78BTaLNp98iBDXaECXOcI6916tNhdlH685uYhl8tFBcTXsg?=
 =?us-ascii?Q?kKLUOic0xce9lbW4VtbNfVE8fj8Cy0WZvy0LH+JvhA8C0Q01mnVL3IU9ZOMx?=
 =?us-ascii?Q?E+WQtS8ciJ6haKCK0ZBAYv8ECeYqWI1ZoMYJC8yFsEf1WDXOdNrKAdJBPjJQ?=
 =?us-ascii?Q?pcz/vBlE/E6eAE7nObY7e80vMemc2djtXfzWuu/gFmVN7+bQDXQfgKD6PTgd?=
 =?us-ascii?Q?V5TYVnO/iMJ1cXlBZ0LILJ8i8h4Rc7JwgTb/THQnZYfTVLnv5AbCPK1ReZCt?=
 =?us-ascii?Q?SAfbvtYFHGh1MBkC1ZseVWtdfJOJiD81FYNA6zfGcX8jBSsIz9LjET1nryFW?=
 =?us-ascii?Q?urIIwsbfIYVOD9ObaeV/2jS/5DOvcJ8hkZAE1sciQSTKcCOfkm+KktjumQSB?=
 =?us-ascii?Q?F44lkRFnqzoQ4buzmxg9Xb9BBtFqvjjqhSfJUCSRlB9/r0bCZGEAWOXRVw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ebb532-d3b8-46a5-ff45-08d9e39f5435
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 03:19:30.1141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2EOKpwbW0gclCHfpeXXJy9LDzPBWt9AwtUliTTF5KlbudwMOUCJkCLeTuMq3i+Zc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Saturday, January 29, 2022 8:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
> infinite loop
>=20
> 1. The infinite loop case only occurs on multiple cards support
>    ras functions.
> 2. The explanation of root cause refer to 76641cbbf196523b5752c6cf68f86.
> 3. Create new node to manage each unique ras instance to guarantee
>    each device .ras_list is completely independent.
> 4. Fixes:7a6b8ab3231b511915cb94cac1debabf093.
> 5. The soft locked logs are as follows:
> [  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           O=
E
> 5.13.0-27-generic #29~20.04.1-Ubuntu
> [  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU,
> BIOS T20200717143848 07/17/2020 [  262.165698] Workqueue: events
> amdgpu_ras_do_recovery [amdgpu] [  262.165980] RIP:
> 0010:amdgpu_ras_get_ras_block+0x86/0xd0 [amdgpu] [  262.166239] Code: 68
> d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 38 48 85 c0 74 32 44 89 fa 44 89 e=
6 4c 89
> ef e8 82 e4 9b dc 85 c0 74 3c 49 8b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8=
 28 48
> 39 d3 74 25 49 89 c6 49 8b 45 [  262.166243] RSP: 0018:ffffac908fa87d80
> EFLAGS: 00000202 [  262.166247] RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e=
20
> RCX: ffffffffc1394248 [  262.166249] RDX: ffff91e4aa356e20 RSI:
> 000000000000000e RDI: ffff91e4ab8c0000 [  262.166252] RBP:
> ffffac908fa87da8 R08: 0000000000000007 R09: 0000000000000001
> [  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12:
> 000000000000000e [  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc13943=
20
> R15: 0000000000000003 [  262.166258] FS:  0000000000000000(0000)
> GS:ffff92238fb40000(0000) knlGS:0000000000000000 [  262.166261] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [  262.166264] CR2:
> 00000001004865d0 CR3: 000000406d796000 CR4: 0000000000350ee0
> [  262.166267] Call Trace:
> [  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu]
> [  262.166529]  ? psi_task_switch+0xd2/0x250 [  262.166537]  ?
> __switch_to+0x11d/0x460 [  262.166542]  ? __switch_to_asm+0x36/0x70
> [  262.166549]  process_one_work+0x220/0x3c0 [  262.166556]
> worker_thread+0x4d/0x3f0 [  262.166560]  ? process_one_work+0x3c0/0x3c0
> [  262.166563]  kthread+0x12b/0x150 [  262.166568]  ?
> set_kthread_struct+0x40/0x40 [  262.166571]  ret_from_fork+0x22/0x30
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++++++++++++--
> -  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 --
>  2 files changed, 33 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 9d7c778c1a2d..b0aa67308c31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -75,6 +75,13 @@ const char *ras_mca_block_string[] =3D {
>  	"mca_iohc",
>  };
>=20
> +struct amdgpu_ras_block_list {
> +	/* ras block link */
> +	struct list_head node;
> +
> +	struct amdgpu_ras_block_object *ras_obj; };
> +
>  const char *get_ras_block_str(struct ras_common_if *ras_block)  {
>  	if (!ras_block)
> @@ -880,7 +887,8 @@ static struct amdgpu_ras_block_object
> *amdgpu_ras_get_ras_block(struct amdgpu_de
>  					enum amdgpu_ras_block block,
> uint32_t sub_block_index)  {
>  	int loop_cnt =3D 0;
> -	struct amdgpu_ras_block_object *obj, *tmp;
> +	struct amdgpu_ras_block_list *node, *tmp;
> +	struct amdgpu_ras_block_object *obj;
>=20
>  	if (block >=3D AMDGPU_RAS_BLOCK__LAST)
>  		return NULL;
> @@ -888,7 +896,13 @@ static struct amdgpu_ras_block_object
> *amdgpu_ras_get_ras_block(struct amdgpu_de
>  	if (!amdgpu_ras_is_supported(adev, block))
>  		return NULL;
>=20
> -	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +		if (!node->ras_obj) {
> +			DRM_ERROR("Warning: abnormal ras list node");
[Tao]: dev_warn is recommended.

> +			continue;
> +		}
> +
> +		obj =3D node->ras_obj;
>  		if (obj->ras_block_match) {
>  			if (obj->ras_block_match(obj, block, sub_block_index)
> =3D=3D 0)
>  				return obj;
> @@ -2527,6 +2541,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>=20
>  int amdgpu_ras_fini(struct amdgpu_device *adev)  {
> +	struct amdgpu_ras_block_list *ras_node, *tmp;
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>=20
>  	if (!adev->ras_enabled || !con)
> @@ -2545,6 +2560,12 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  	amdgpu_ras_set_context(adev, NULL);
>  	kfree(con);
>=20
> +	/* Clear ras blocks from ras_list and free ras block list node */
> +	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
> +		list_del(&ras_node->node);
> +		kfree(ras_node);
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -2754,14 +2775,22 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object *ras_block_obj)  {
> +	struct amdgpu_ras_block_list *ras_node;
>  	if (!adev || !ras_block_obj)
>  		return -EINVAL;
>=20
>  	if (!amdgpu_ras_asic_supported(adev))
>  		return 0;
>=20
> -	INIT_LIST_HEAD(&ras_block_obj->node);
> -	list_add_tail(&ras_block_obj->node, &adev->ras_list);
> +	ras_node =3D kzalloc(sizeof(*ras_node), GFP_KERNEL);
> +	if (!ras_node) {
> +		DRM_ERROR("Failed to allocate ras_node");
[Tao] dev_err is better.

> +		return -EINVAL;
[Tao]: how about return -ENOMEM here?

> +	}
> +
> +	INIT_LIST_HEAD(&ras_node->node);
> +	ras_node->ras_obj =3D ras_block_obj;
> +	list_add_tail(&ras_node->node, &adev->ras_list);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index a51a281bd91a..a55743b12d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -493,9 +493,6 @@ struct amdgpu_ras_block_object {
>=20
>  	uint32_t sub_block_index;
>=20
> -	/* ras block link */
> -	struct list_head node;
> -
>  	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>  				enum amdgpu_ras_block block, uint32_t
> sub_block_index);
>  	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
> --
> 2.25.1
