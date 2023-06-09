Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48028C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 17:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E1F10E16D;
	Fri,  9 Jun 2023 17:55:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1039E10E16D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 17:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKeyg4tx8lj+tGJmC/vFeHEeGLbeD4CjMeBL/8fqQ5vg72Ijiic8vOtmA0ClBXxsjN/u9fnkmca/hvCoq0gLTe8EdLYi2CNczYymB+Ekm61TGRbNGNIeFbh5bw2Mo5s8u3ntsNOIQQEclHhm0yQ4JK281LvX3D3+l6qqoZqzAyraWzKrl+Gh8I2/V4/DtFVx44FFApP7rVp8u/G7FONfIb8iXuEubB/nMrNbb7Fr6D7jbeRtDbfof0Ge6ukIB8qc2Vn394lEBzANpQCaF3ZlYblgoKnv2NAxQGoarzEtyD0DApHwOGsOHIDl1sxNZ9AhyM3BVjdVwvmWq/uNSLpmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBnWwnTideXfgssLW6IQMiafZSWwob6R4aemBY0dIZQ=;
 b=HabGmH+V/e12LncRKHV3a3HYw8Hc5H+uaUzTl1k8jwwDvOTPLnSa1bmVvg0qHG5mkrJpPw14w2e9z71L/vtnmW9iirn7vEB14TNyIAQV4VM5K4fXoagD3yc2f8B038cnwBPohteRW/f5ye0vwK3dfM8Vm5Y2Q567k9F4BM+YNcOIhNx66kFtsGQlziFtkZ0huY2CFyK4zk89kjW9dYdrYJG3JuPxXiJI071pw5c4LPK5+jd/+7IYiJ+6Dq5acEz2Bi/u4Vn34mkMHoAWZI0Rv+O/30GA9W3RStaJz7ZBytmD4SmY0QDhOcR+qRAU75PlZzgo+ziI6iipymLIzHNKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBnWwnTideXfgssLW6IQMiafZSWwob6R4aemBY0dIZQ=;
 b=QoRpcjYDehqxWlGlavkYpVe+C8BY6V8idRW2mqseqdNqyMPq+PJAbYyi8MHQGBEDr9CxBn+ssP59QbsdCva5R3Lv4/C1BuRLhW1BgjjvcRtxOutbXJLe99v0Qgwv2ss/1fQlhq55UPE+vKz+20GnXf5nb2w+P7E/xhHXX28aAdI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:23e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 17:55:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:55:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix memcpy() in
 sienna_cichlid_append_powerplay_table function.
Thread-Topic: [PATCH v2] drm/amdgpu: Fix memcpy() in
 sienna_cichlid_append_powerplay_table function.
Thread-Index: AQHZmq7ALw0A3TgHRUyUAB0kvsMGcK+CwcQi
Date: Fri, 9 Jun 2023 17:55:44 +0000
Message-ID: <BL1PR12MB514413D3D2CE3436B9ED4EF9F751A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230609084513.261487-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230609084513.261487-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-09T17:55:43.138Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB5613:EE_
x-ms-office365-filtering-correlation-id: 4ae665b6-5000-48fc-9849-08db6912bf36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhJqbd83humyncH/Nr/Xq9hYW7M01VIDbgJT8r9O338BUcMbABMfszGo/5O6rUXyegRY4Ax7mC10t2BI/jmTmYvFsFpy1SADvmjVpansoR3p1RLfh23bvW6B7F5EYoHgvc1IE54DJ3G5Awa9THR2M0WfvzcoAeB0+YJzt+o8KXSG0icjDCpsQZ8OUXMJiFf4nCWH+cLky3az6vvXHNcl8opj/h8rf7YbvweyeZEUxDUvYJNGkgfLPfrCkd7W4Tr2wZLPTtFfUKyWmAyh9srbEVzvR+egzwOnXbNqaJaLNEWHmDHgEuX181d7Sg7HKpVUqQrNZJQfS4F5zgWyycPjpq8n0gAetjkDqv6ORwEfcQLdHP/k19dFrDyANP7fAdvktJVhhPyt3rS9bb5ZJ89xiyxk8tmjDWMuXdPGh9AQfeYzgLw10J7mzRzp8B1ack0cvU2fSnwOgebu3ay+LEh6mqZGn2/XnanjIHeN+t5BZ/oW2Bmp4LFiWMQs2VKsacdryHUWblSdRXWm/j2HO1qMx7cC7nf2SAFK+yJoI7eUF2DH6S9ejlnVd8s9kFfxT6iIUV6PzSU57PgSxYSiIDBFlgZ+RNcfNBenObSRW/EsJuJ0eT+BedQpIeQBy0DDsjtLRcZLpOtCbdjz3A6GjyZmrg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(19627405001)(38070700005)(2906002)(86362001)(33656002)(52536014)(55016003)(71200400001)(66574015)(7696005)(186003)(83380400001)(9686003)(26005)(53546011)(5660300002)(6506007)(122000001)(478600001)(19627235002)(110136005)(66476007)(64756008)(316002)(66556008)(66446008)(4326008)(6636002)(76116006)(38100700002)(66946007)(41300700001)(8676002)(8936002)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?l4oOeh+cy3KqXJafAqJc1ygBaloqpAS/GmLXVv0qphAhZaysv9tdxLbU?=
 =?Windows-1252?Q?MO4bTDjmV4xddXOGCxyJWmHkbecb6ta6wsR9ZNfz+5Ktth6D6LXotu/p?=
 =?Windows-1252?Q?+r072qARNp4BjWaQU3XmaoxuSf2aJ2ltjqQ4dEh++l/0OQfkuTkDrLVB?=
 =?Windows-1252?Q?Cs8bjCr8P0VB/u0p5Axcvsc9SkOqhGq3HE9CVHaR9k1jvuoR7o98B6Sx?=
 =?Windows-1252?Q?9LfsI+HlIwdnqHez47jd03qHAoz+z0RIwMxr5GUxhecgMw3xcnMhhu7g?=
 =?Windows-1252?Q?L4bmamlIrz/Wg9QKdg+ZfPAna2iMP8VLvz+3krZP3WqB6FxaFCPahtpw?=
 =?Windows-1252?Q?nqnxtHhWJivh2JZt050XjWkiuh8gfMtAkOVuF36P7T4gUhUPvICjte3N?=
 =?Windows-1252?Q?7/qmJIztpEJNtrYxF8oDxLZ/99cSl3on3z8Y0tbXqr05sInYibmN12XE?=
 =?Windows-1252?Q?3TenQ51iCDNcHv9TyJHNNO88DWhWAiGorTXp1Kzb7K0Qwpt/UNqfeo96?=
 =?Windows-1252?Q?I2Fs6FB+olTTPCfcbpM39UaAsb9kskNNexWLyqGcmmOtpWrqYz/DOdvR?=
 =?Windows-1252?Q?JEmD3Wg7IqVJs4v6MTSiGsw1Q28n5+/WocNceoE+bWmF8yw2YCI4ii5t?=
 =?Windows-1252?Q?uJWgRKWWkqu13FLywjdW5muvhOTrKSke0SQmKFoIbS7rSJA8OlQvDgSY?=
 =?Windows-1252?Q?UqN87RV4pGuv1m0uW5Ybj71EZ1/Z9I6Y/1BbD1SNBfd26FigbLlMa6T3?=
 =?Windows-1252?Q?LF6z+E6gyg0ilZX8JACBeGyBbTzcpnTcARpk/m4Xy7QMk902en5Z4gLv?=
 =?Windows-1252?Q?F0PO49sCpS0RE+2nr0UGIAlkY58+b8SN3vSIveTqxTUfQdtEwD36JEjN?=
 =?Windows-1252?Q?R00TC/tVFlYh9RhFWDg/fQZ12KnpQ4g/Ne7ZkxCglqMmGMMmWUh4CszY?=
 =?Windows-1252?Q?0P1O1Ol6oTTm8XkhoOiV3VxX4qoM+txtGc/0rA1xoll9RkQ1YtMPdj0i?=
 =?Windows-1252?Q?T/zGRKlF+VJHWXfolY/9jeur0ANLp5HQ+k1BB/S8t3qbrl7tGzoVib1r?=
 =?Windows-1252?Q?tyYNzsZAyK60KWxLXkwXfCABmpiTaEvgm9mPUJqqAkSEF7RavNkVF+5o?=
 =?Windows-1252?Q?ArxbruEGsxdF+zQbvUaoQHTTnGJRY6UsPdN+neGkJ5mF5Wi9LuuodMy5?=
 =?Windows-1252?Q?3/e3a489DMU4WGQ4s3TGNN12AH4IXsaSMGsNrmwl5hxoUlXLrAt/M6Oq?=
 =?Windows-1252?Q?sbz/Kk7IfA/HVeLzakETlupHwKOOWT7zlVDzTuoM/xdJ93wDJ7RIzfaN?=
 =?Windows-1252?Q?xtTt4yzNRJB1pQVi9Op/xbt9fKCjdVa+zJcjkfgEu+tI3bmqcY7LeVXA?=
 =?Windows-1252?Q?VibIek35yRUu2OiOaC/A8ncMnMcZpyrqzq+gmmzt3X/qNzNQk8Wk4Lzo?=
 =?Windows-1252?Q?OnRsr66tWOKfr4BptL1BOxEKnmVTatLBOWpEMMH1WttS6T9Z3TfpoTCL?=
 =?Windows-1252?Q?NMd/740i72IGtqWsRZ69CJcyRp3ycF2agmQsRAxeOV9Al+n8GBXjvFxa?=
 =?Windows-1252?Q?2L9Zv7in+nUgSSBiTik3b0/Lyuo8FC8J95+w0FRs4qpqXsWI4Lw67DD1?=
 =?Windows-1252?Q?yDKnJB27Ss3BS9BzagTNIeCc6Bj36r3dLB6Hio4sBcZ0a/vAHsjy1vFB?=
 =?Windows-1252?Q?aUAaHILiPYs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514413D3D2CE3436B9ED4EF9F751ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae665b6-5000-48fc-9849-08db6912bf36
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 17:55:44.1013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBH8/9/ad7EdAx7t5twbjXaleayjCAFnDKBU5CX8evoddGusmoGNaX8JqtQxuEuXh/M+wkUPg+BymOnD19wa4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514413D3D2CE3436B9ED4EF9F751ABL1PR12MB5144namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Friday, June 9, 2023 4:45 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Gui, Jack <Jack.Gui@=
amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix memcpy() in sienna_cichlid_append_power=
play_table function.

Fixes the following gcc with W=3D1:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/firmware.h:7,
                 from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_c=
ichlid_ppt.c:26:
In function =91fortify_memcpy_chk=92,
    inlined from =91sienna_cichlid_append_powerplay_table=92 at drivers/gpu=
/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:444:2,
    inlined from =91sienna_cichlid_setup_pptable=92 at drivers/gpu/drm/amd/=
amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:506:8,
    inlined from =91sienna_cichlid_setup_pptable=92 at drivers/gpu/drm/amd/=
amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:494:12:
./include/linux/fortify-string.h:413:4: warning: call to =91__read_overflow=
2_field=92 declared with attribute warning: detected read beyond size of fi=
eld (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  413 |    __read_overflow2_field(q_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ^~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~

the compiler complains about the size calculation in the memcpy() -
"sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header)" is much
larger than what fits into table_member.

'Fixes: 7077b19a38240 ("drm/amd/pm: use macro to get pptable members")'
Suggested-by: Evan Quan <Evan.Quan@amd.com>
Cc: Evan Quan <Evan.Quan@amd.com>
Cc: Chengming Gui <Jack.Gui@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - turned to the way used for nv1x (Evan)

 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 85d53597eb07..f7ed3e655e39 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -431,7 +431,13 @@ static int sienna_cichlid_append_powerplay_table(struc=
t smu_context *smu)
 {
         struct atom_smc_dpm_info_v4_9 *smc_dpm_table;
         int index, ret;
-       I2cControllerConfig_t *table_member;
+       PPTable_beige_goby_t *ppt_beige_goby;
+       PPTable_t *ppt;
+
+       if (smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13=
))
+               ppt_beige_goby =3D smu->smu_table.driver_pptable;
+       else
+               ppt =3D smu->smu_table.driver_pptable;

         index =3D get_index_into_master_table(atom_master_list_of_data_tab=
les_v2_1,
                                             smc_dpm_info);
@@ -440,9 +446,13 @@ static int sienna_cichlid_append_powerplay_table(struc=
t smu_context *smu)
                                       (uint8_t **)&smc_dpm_table);
         if (ret)
                 return ret;
-       GET_PPTABLE_MEMBER(I2cControllers, &table_member);
-       memcpy(table_member, smc_dpm_table->I2cControllers,
-                       sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->tabl=
e_header));
+
+       if (smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13=
))
+               smu_memcpy_trailing(ppt_beige_goby, I2cControllers, BoardRe=
served,
+                                   smc_dpm_table, I2cControllers);
+       else
+               smu_memcpy_trailing(ppt, I2cControllers, BoardReserved,
+                                   smc_dpm_table, I2cControllers);

         return 0;
 }
--
2.25.1


--_000_BL1PR12MB514413D3D2CE3436B9ED4EF9F751ABL1PR12MB5144namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Friday, June 9, 2023 4:45 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&=
gt;; Gui, Jack &lt;Jack.Gui@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: Fix memcpy() in sienna_cichlid_appen=
d_powerplay_table function.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes the following gcc with W=3D1:<br>
<br>
In file included from ./include/linux/string.h:253,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/bitmap.h:11,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/cpumask.h:12,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./arch/x86/include/asm/cpumask.h:5,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./arch/x86/include/asm/msr.h:11,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./arch/x86/include/asm/processor.h:22,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./arch/x86/include/asm/cpufeature.h:5,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./arch/x86/include/asm/thread_info.h:53,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/thread_info.h:60,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./arch/x86/include/asm/preempt.h:7,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/preempt.h:78,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/spinlock.h:56,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/mmzone.h:8,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/gfp.h:7,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from ./include/linux/firmware.h:7,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sie=
nna_cichlid_ppt.c:26:<br>
In function =91fortify_memcpy_chk=92,<br>
&nbsp;&nbsp;&nbsp; inlined from =91sienna_cichlid_append_powerplay_table=92=
 at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:444:2=
,<br>
&nbsp;&nbsp;&nbsp; inlined from =91sienna_cichlid_setup_pptable=92 at drive=
rs/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:506:8,<br>
&nbsp;&nbsp;&nbsp; inlined from =91sienna_cichlid_setup_pptable=92 at drive=
rs/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:494:12:<br>
./include/linux/fortify-string.h:413:4: warning: call to =91__read_overflow=
2_field=92 declared with attribute warning: detected read beyond size of fi=
eld (2nd parameter); maybe use struct_group()? [-Wattribute-warning]<br>
&nbsp; 413 |&nbsp;&nbsp;&nbsp; __read_overflow2_field(q_size_field, size);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~&nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
the compiler complains about the size calculation in the memcpy() -<br>
&quot;sizeof(*smc_dpm_table) - sizeof(smc_dpm_table-&gt;table_header)&quot;=
 is much<br>
larger than what fits into table_member.<br>
<br>
'Fixes: 7077b19a38240 (&quot;drm/amd/pm: use macro to get pptable members&q=
uot;)'<br>
Suggested-by: Evan Quan &lt;Evan.Quan@amd.com&gt;<br>
Cc: Evan Quan &lt;Evan.Quan@amd.com&gt;<br>
Cc: Chengming Gui &lt;Jack.Gui@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
<br>
v2: <br>
&nbsp;- turned to the way used for nv1x (Evan)<br>
<br>
&nbsp;.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp;&nbsp; | 18 ++=
++++++++++++----<br>
&nbsp;1 file changed, 14 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 85d53597eb07..f7ed3e655e39 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -431,7 +431,13 @@ static int sienna_cichlid_append_powerplay_table(struc=
t smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_smc_dpm_info_v=
4_9 *smc_dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int index, ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2cControllerConfig_t *table_member;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_beige_goby_t *ppt_beige_goby;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *ppt;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] =3D=3D IP_VERSION(11, 0, 13))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ppt_beige_goby =3D smu-&gt;smu_table.driver_pptable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ppt =3D smu-&gt;smu_table.driver_pptable;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D get_index_into_m=
aster_table(atom_master_list_of_data_tables_v2_1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_dpm_info);<br>
@@ -440,9 +446,13 @@ static int sienna_cichlid_append_powerplay_table(struc=
t smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (uint8_t **)&amp;smc_dpm_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GET_PPTABLE_MEMBER(I2cControllers, &a=
mp;table_member);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(table_member, smc_dpm_table-&g=
t;I2cControllers,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(*smc_dpm_=
table) - sizeof(smc_dpm_table-&gt;table_header));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] =3D=3D IP_VERSION(11, 0, 13))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_memcpy_trailing(ppt_beige_goby, I2cControllers, BoardReserve=
d,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_dpm_table, I2cC=
ontrollers);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_memcpy_trailing(ppt, I2cControllers, BoardReserved,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_dpm_table, I2cC=
ontrollers);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514413D3D2CE3436B9ED4EF9F751ABL1PR12MB5144namp_--
