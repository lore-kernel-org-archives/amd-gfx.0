Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA5EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 03:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C46610EFF1;
	Mon,  6 May 2024 03:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ft/uv0a1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804FF10EFF1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 03:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOnNBon0oIE6FzMzy8CQ/TuiYmJe9VodtPR6A4sfXL7swIn/EjUuO9cm7hKUfir5ESYLW4msw/AdtvA4JQX9B5AUlMYeKonVDF+1mRZ0a1rqm51DwKOqmg+YyCtjFvy1gU0VWj8z06D5mzb70ILZnyg930tjCebzLGSKpWggE8H3WvzHKXO6276mZbFb89JU59JxcFXW1/cspOL6d7+EhYhTSKWMfY2xE7YVuV7M7chAyJlIad4LRgg5QZZ0QAhQQI6OmJry1NB3elVw8t7dLkEGO0OSrTfLwLeRWlxk3TTgcGsWRi1TFTX3/hXA+UUAAfsGTsN6MtcvIuBirWvduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCnLbp6AWQGnf0tDW9ok2I5sxZ6ZBx0LsIJyu7Vb3J0=;
 b=F6dZwyAB57LFed5zrOjJcw+ihIPSfW0BVWzNtHp7/cF9TbZ8gFctDRcnYBReKjWeJV3RT3xxh6Oa69xbJNX+0MGEaRKsrspuMQwREm9xk6Cb4ArXgu2VZrFAVu4Iau7sSW5Z1eHA0If5dOmTK8vRTGEn74rsJhMrXDR6gcgr9Bp3AuBE+DDwgAFPdNV4nr9in2ZKbcjmC9lAd4WzWKXB7be0+aYUK8AU/H1l84atJclcuNcgL0U/zamXEsfWBp0PRo0j+oESyeE/Gyq5O02L6dJ8j2yOHxKMpbJI4D45jsxzE8xsPxJHjmN+205qkDhD5yQFLohopatQF1GgvaARgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCnLbp6AWQGnf0tDW9ok2I5sxZ6ZBx0LsIJyu7Vb3J0=;
 b=Ft/uv0a13V+fQn+RVJY1bdr6qXM0iXWfTbwxhFs5+jQKz2R7Av1gPDqCpe9Hie0+Ui6kM2X/VsH+yKnxRlXi1bEwq7WcBLQA9uWg3U1gtwaMKW+s0JObHDwKTuBgo1dcjbq7Y0OX8BhM9IGaQp/bFXw8ctqyoHcjmBz/CGTXosU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 03:37:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 03:37:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: RE: [PATCH] drm/amd/amdxcp: Fix warnings
Thread-Topic: [PATCH] drm/amd/amdxcp: Fix warnings
Thread-Index: AQHan2XnHmrmqN5cqk+ZxsAIOSdeCLGJjoBA
Date: Mon, 6 May 2024 03:37:19 +0000
Message-ID: <BN9PR12MB525794DE77825A258C86F907FC1C2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240506033111.17883-1-lijo.lazar@amd.com>
In-Reply-To: <20240506033111.17883-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=75d03385-a065-453e-96c9-8351af3576a4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-06T03:36:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9252:EE_
x-ms-office365-filtering-correlation-id: e4cfb459-32ff-4a6f-30ee-08dc6d7dd51b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?c85KPzHX+UkftYEg8XrEHVSyG/178hpb4sF/xszn0irYYMx5+for6tBzJmyg?=
 =?us-ascii?Q?9vLUBgs89SBQxihg9UntnB9Pe7WoUbX4yYFMQSDBiyGbJeMPvfm6aGhJvKtS?=
 =?us-ascii?Q?XzShyFllSDVIGl72VqaMQ5M9HVIvnEiAcAP4wDuLDFjEhYWBQZyn3+wH2Dqz?=
 =?us-ascii?Q?8DR15nRH39FqVlQgcFZwDHt+0i80Ow7UjM5JRr/sh0RiPRRisrQoduO8I7p3?=
 =?us-ascii?Q?219nF7MCoVWGw733RpSuPLyQ0S7Uh73WbYDCN8tBIrHl2QfkwJ1D3Bq5O5Qk?=
 =?us-ascii?Q?bamXsymsn2iPLch3U6nd89OiFKYTOebQROVkPpU3zklzNE1Blx68oCy0AAfM?=
 =?us-ascii?Q?Z+Rh9iBftexquLb7ZOQsEUBMSM6TPiOweROZ8eTLlQpPbaEks8drwmJ8QaN4?=
 =?us-ascii?Q?FjFT158SGTskDqhB3r7i3qs2vLEQuvx4vaS7Q8AhKObPopr9fJPHegmZN61F?=
 =?us-ascii?Q?anLiNAL8txzdsMJP9jSJ+XrUAdvGwvUCyXvIJa/BM4mI8VMqb/ZwfBJoTFAp?=
 =?us-ascii?Q?CoKZGDd3hfUgMn5qblNCiFc4aiN//iq2C3y2oliJyIhsCWeL/FkFCxlsH3fj?=
 =?us-ascii?Q?T1IGitX4ex0YAd6DjOJ4hoefNNACNMpGdnzQ1eCZFQGR8iLPYIesdzMYBCX3?=
 =?us-ascii?Q?oWuEl5xSuiYH9ouOA+42mZn370cI+1oxP4GPGdpLkrDD6CJga6WTFcPG7HvO?=
 =?us-ascii?Q?0kNK0Wh9tx/qjrjoyodiYNl6V9R4DPZC/JMMtXJDDOYOJCbgazborrXc3+gD?=
 =?us-ascii?Q?1NfjybY/kZq8yYE21FuPjvEAyEPaXzOSnI7SvfKFE1lS7zbsE/92yTLrXI22?=
 =?us-ascii?Q?GqmztcomQ71lXeSgk4SPe9R2HZ3Yuv4p7UyzE+ifUGfI435xsZACiDr6Lj4H?=
 =?us-ascii?Q?e1Xcz7C+DlAmBNA4SbxgHcwvHePH4ewzZv6tkZWQJsWhXJcS1WzcCRhn0r9k?=
 =?us-ascii?Q?YnCg+HbLEbrsP9yNs3dtIyc0NSpZygQJz07xeX/ZfbgcV+5UlW7qWlEcIKIp?=
 =?us-ascii?Q?1kNIWmECWSFz426SCNaGWaw/boJX8g+lqlQBzz222OgkbIrFb4Euhf4ZttSp?=
 =?us-ascii?Q?16WDj/qAvUVMpnb28Hv7kRSlDHXN9qZPfMG99exPxtP7MIX6v60XZNGfzOfb?=
 =?us-ascii?Q?6++CjfaPTb4tXM1v8UBJ0wROvcsRbazbpCBZ869NGlMw91ZtD+ZT6GwfaKGt?=
 =?us-ascii?Q?1lh63+lSBPepp2WzVD/EuSX+nkjWl04rFu/HCMlc7Fn6m9hHUfPCaB5+MR4s?=
 =?us-ascii?Q?tp3OTSrsJK2QH/W9o6Jo2zIZ+7UB2Nemp5O1L9fT5HnOGIcMdeleKSIgXNOJ?=
 =?us-ascii?Q?TObp7VEnixqriwEEJb4wz8eAwAfIeQYmISy1D2ldsUoY0w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ou1PepN+MCha0myC1jej02mOg4cHQDgFIV0EyNVlxFDE+OcH5fkSgNOP/dEt?=
 =?us-ascii?Q?B9bNBUgBMBNEIZZJHRo9cfoCji8poRIWhuy38MjRqsrZ4F/a1B+itWY9eL7m?=
 =?us-ascii?Q?uKzJiTnAfjxw3gUTItz2XalGYj9akPxUTJturuZ7J9neerqgfCQPOAitVJKc?=
 =?us-ascii?Q?W7fqWsmikOkFBhQuz23q8Tk+VVpcq2vL8NY8lITa9eYM5UnyR25BraY/Oic9?=
 =?us-ascii?Q?p4t7G5MQ7jiiR6BNdWsV9qvK3MYUEIR89LXvjcFI2iB9AvvZsNTWKabRDAF9?=
 =?us-ascii?Q?loQK7pqBc9Tz9FdFrQ/Wp1+Jd2Mo/n/pydPHxBuIbA06ecLiTT6OmM++Lck1?=
 =?us-ascii?Q?75fAFaMzcGs74Om/LJiYxTnGoWZkOqjvxBm7r+iKGDhyrUsOgnv7SX/NYmqX?=
 =?us-ascii?Q?oHxeFkI8I4EOc74N/Bhpoz89eYQqfwrC94OmuFeFnT6I6Ek8sAA32avg20SR?=
 =?us-ascii?Q?/9PAL+SwOrTIQpvm8sYis9PT9hnkqMfQXO0hb+/NG/eUxoqnOry+WxE6q8sj?=
 =?us-ascii?Q?KARdKJickuD8JTW8+ivdX53Xfn4LjXBVe8juaqoAWKMNCC/MtdSeoEuPgDx9?=
 =?us-ascii?Q?vH+pZ3lFIKKur5JOMP/Jq9itIpiasLe4kRkXpG8e8tJVQi3u5VLgidLa75sp?=
 =?us-ascii?Q?tf7EivmQ+H2RqgvL09qC501pKJCQditPy1Z3q6ptH2pfILkgSclvQpAe8tE/?=
 =?us-ascii?Q?6WKI4O/7wDGYSI/DCv9Clt4OXdfTuU9sVwiPxBTFEhxuVXiGBPDq34fr53nC?=
 =?us-ascii?Q?HKOlDv6uKMG0GMNVuw0MGdfHV/hk23CCEjBQZJx07Itz1xB7Pa0h8I8pgyvL?=
 =?us-ascii?Q?czggKK7BboBw1oQPo7J8Lx0m5BcIIJ/keNm3iORKtwtx5pi3JLoWLe+HKLbd?=
 =?us-ascii?Q?J41YMcTo+O5l3kUQUsyjmqm6Kim94EIqOq6+P35BT725LO5OEDZCU+zaQHUR?=
 =?us-ascii?Q?MH3d0BkQgN3uCS7b2bvNkPrdDraKnmjD3XTQy3aC2MM+rSkuFiuMT3QcuSNY?=
 =?us-ascii?Q?17QedoCvk3CK2c7n8c4e1KQq/2RYwTgubTGI6DbGpADLYC3GsezDnV7ynA2K?=
 =?us-ascii?Q?kgeZXUvLyTj9y+GTPakzQkHdKAd7O8QKv2PcZrDBFJCc2T/bHBCIAMk4+eyw?=
 =?us-ascii?Q?ZieEPt7kOvVO7GwjsT1VtWz1brZL5TuEFlq1qrXsDQ3rp6/B7A4MaZe0KPJO?=
 =?us-ascii?Q?EghwSS7NdAq+XM5k9UrbYaHesPB1BUKQHkw+IH9yDqAtvGlkIGf/rTcEH88Q?=
 =?us-ascii?Q?DIkD7+2UEt4BKau/KBK/VV+XLhZQzfyRR3fwmtk2ymJnV3A6Gc64l+qdu8uG?=
 =?us-ascii?Q?RULJ8I693JNBS4nHo6ecLANbElsTaogwJTXUYpO/kM9KDfAKmj9bnRP3+KpU?=
 =?us-ascii?Q?r9jUnfjdME7z5dUbz0qD0RBkkTzhm66Mfs+IKODq52oiQR3DEViSfNwTEGju?=
 =?us-ascii?Q?roEkKD0a1U+qZH28otFklAow56PIpqaF5rsY9IfPoOU4ZeMjPcc0hPY4gEAz?=
 =?us-ascii?Q?4St2sXKUWU9dWNyoOPftDZv33dnK+xfpdFdDoyaTBEQU3fchvNGyId3KWRR+?=
 =?us-ascii?Q?VseG1hLzDafjTEnf9Vlr7dFe3el/qiuXYnuWBXcm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cfb459-32ff-4a6f-30ee-08dc6d7dd51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 03:37:19.3163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0MzAio2Qg3iyt4WAJ8VBjNhRjMLNO5zPK4qtvlvXTKY26i07cJ9FjSeRLULvhYCpRi0RSDvIFbx3doUwJtd6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, May 6, 2024 11:31
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/amdxcp: Fix warnings

Range of possible values of pdev_num is 0-63. Use int8_t as data type.
That also fixes below warnings:

>> drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c:59:58: warning: '%d'
>> directive output may be truncated writing between 1 and 11 bytes into
>> a region of size 9 [-Wformat-truncation=3D]
      59 |         snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pd=
ev_num);
         |                                                          ^~
   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c:59:46: note: directive argum=
ent in the range [-2147483648, 63]
      59 |         snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pd=
ev_num);
         |                                              ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c:59:9: note: 'snprintf' outpu=
t between 13 and 23 bytes into a destination of size 20
      59 |         snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pd=
ev_num);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~

Fixes: f3b4c9a2746c ("drm/amd/amdxcp: Use unique name for partition dev")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/=
amd/amdxcp/amdgpu_xcp_drv.c
index b4131053b31b..faed84172dd4 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -43,7 +43,7 @@ static const struct drm_driver amdgpu_xcp_driver =3D {
        .minor =3D 0,
 };

-static int pdev_num;
+static int8_t pdev_num;
 static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];

 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
--
2.25.1

