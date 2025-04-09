Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6A3C36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 09:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0290510E825;
	Wed,  9 Apr 2025 09:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0hIJvI0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F6610E825
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 09:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b21+GbWJ6WSvsPzflnWgdPilqTnGOrKS0tvjLvRjqr0HzmO6kAi46YfFAVRJ8dgmrEcQCpg+EZXxrJvZxQbT7MnDIGhN3133hNxtpoSXbsBc5eerN8hgYijKVrOm7HXer5XVNQHQXffebTAELB0/XZ3+FnGh/mdh/C+DLLL82G/PMy3HVcQl47A6NdZHXbXLChwgjpeHi1q+CVxhdOpLhS1WNLG91CAII8Bq9B9u1qS64BIvXj3LhrZ1JYqWbV55/uFzAh0BTrinxoQna7l0iGAIv9Q1QW98kn+Eot9XGYas8FvIhrPWgDr54tAS/cuKrXmTOhndIbfks1LMmnCTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Rv7b174G6nM1X9fnDbXyOBB29iUL10UY8vKudghtrg=;
 b=xwiKfOeIdbbcLHW/Yy5FH6g0msTUDdVvoh90Ku38HZE0oBKIhBt/f1RoIHZCt9Dt8JvbPlohgak/wnWDLFw7I8phcYvYE2veeD7+EtelmgfaFQK3at6Uu80Fi0z7hg2F3U7v/CiTarHYsnrrZC8Az6xL14weqXdlt4bqUy+iwU1K/dXnoIi8V9E4YcVvKIwZnBTyYQkadKC1DxZnH+b2ZTlQUjtcZ8fnpLPbere2uJaJjmfV0KLS+nTk0Tr7rt5PgSwC+9JprzVHS1LnRdmxUnUevzg6hAs+N8WBbzoQIZq0BUykR+1lR/pVQS1aA1yI2dSomUOL2vHei4+sFOXMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Rv7b174G6nM1X9fnDbXyOBB29iUL10UY8vKudghtrg=;
 b=F0hIJvI0NZqmXn81KWziWXXebpmL76G+lzBaN7hUPUNt7x/E2wPRvrQXcOXzMgclmqDuTw2eg53/0XWcUSIF/wIltls+Efi8mSVFtGhUMqGn3q27bm4OcMQl1CKdFRR5ssAb9gzrUo8fyNidxkfT6mumOLAt4l0IyWOk68sDx94=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 09:44:20 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 09:44:20 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: Re: [bug report] drm/amdgpu: Multi-GPU DPC recovery support
Thread-Topic: [bug report] drm/amdgpu: Multi-GPU DPC recovery support
Thread-Index: AQHbqSv01JmKNmlyAU+JtaQmPZ2697ObEgft
Date: Wed, 9 Apr 2025 09:44:20 +0000
Message-ID: <SJ0PR12MB6967370CC03FF295A6E5BC199DB42@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <ecb6666e-7ef0-4dbc-ad11-df9ca16fac43@stanley.mountain>
In-Reply-To: <ecb6666e-7ef0-4dbc-ad11-df9ca16fac43@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-09T09:44:19.821Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|MN0PR12MB6200:EE_
x-ms-office365-filtering-correlation-id: 2c648333-5e19-4698-3c8a-08dd774b1a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+hR4e6PicPF+t7mMWLMAD3BSaGU8e3dCFRBbolcKoBfBf5wcGxzCOUbLbQ6M?=
 =?us-ascii?Q?MAcL5vISiMZXa6ZaXqN8Y6gPDllDqlkGJ/9O9dxR6dMrhlpGQgJ44kqYqZnP?=
 =?us-ascii?Q?jqBPdSZRZES8Tf1RwG58I8DhqhQUk0whAHCCvuu9XkfPIxTVOLiFmbF/QRyv?=
 =?us-ascii?Q?8Pdh5LpqMLpSMgpz/3k9fowF4CbEON5OxSxi9IQH1IHF2sdEmc9zKRQhw/qf?=
 =?us-ascii?Q?lOk4CTGi0cAF0ZAN6r5omrchnssLE+PqMKEbDdRaSjU86u0H1y/KxguQJMb5?=
 =?us-ascii?Q?IpDaQ8lxtY3lG1b0QdAEa8NW2iwxfoQFI7YoFxmUijAodACZiz0jZfDj+PAe?=
 =?us-ascii?Q?1SOtwZB+AgRCTMBsKDWbrJ6L4YrRFAlS9d5ZQq9w9xALDEmtr2wSvX2zmWvw?=
 =?us-ascii?Q?MD5+uCwvUYWujUGtyknPrWP6WE/9VX0EIjUZdMtuPNc+X5JFkHo42PrkcS7l?=
 =?us-ascii?Q?v8YAksBh2UWRvlpE9bD23+L1RnayMXtTiqslKmtYc2xNn/W/W8ZFbnSz3idE?=
 =?us-ascii?Q?jQFFn4uKO5mC68brNCxGnrJuE+QfmSQPpsuyTQrpiuYA098RY+tJrfJ1Lda5?=
 =?us-ascii?Q?CeWQBl9yUHC4yM3NkXmXXvEV+oegu918jhDal/g1xRNCpe0pUin1PIukvTXw?=
 =?us-ascii?Q?UqgR6ZYSlH4Xo4lUbs2BFfTU5S4gDLLKmSkqfZcgquY2VSNpBSawJdfpY/Ri?=
 =?us-ascii?Q?14v6KykPG0ua92XohzivfVuZRwuiD+2a+Ajdh7+vtoSzCUCuMJp96otvL+53?=
 =?us-ascii?Q?0lkIy+BJy6b8/6h8AfVU/kCtS/+7krxklslHaCenKT7rXvTg5EGk3uchIhsU?=
 =?us-ascii?Q?d3hCQxC0GE/jykWeAZgpRWPKzRhLFKybIWfHhMqSAgSKECNy62RW23JU2tU+?=
 =?us-ascii?Q?lH+FJuy9gB7A0B+OrQwK8Y+1AnPs4JeK9tTcoc+ifelwP5zfqqBiU1Qv85Kl?=
 =?us-ascii?Q?sxoogyvDwuJgz5elXGOxW5OhDHWgq6mBPvPj8O18lNVwap2xNZeS+tUhDOWg?=
 =?us-ascii?Q?jstxxHymfiTkyPX8lG4BpKBpcrDSnt1IGNAqAf2vuFaCPXcfwXn9bfe9Y07S?=
 =?us-ascii?Q?awD7F7UjEDBPY27vVHfYrzBEMk0I/1gdp9YGHtQaJHrzwQhgLC67q0G9sslS?=
 =?us-ascii?Q?fzFICChTOfk0IX/UKrxbq6sI8OaTNzl3Ww/1syJwQxKr1b2Nn3FcffGBwh5/?=
 =?us-ascii?Q?qjXYQSoVZCBJwRmBsF4GjM8rT0bD6UPFbA8NI7hnjkOpdtP3mA4D0iqIpAMF?=
 =?us-ascii?Q?tDhsMqpZ4Z9Ie8veW20jN9BoOuKhh2k/LyuBFT74DS9LMnOniEYAwZAT73tB?=
 =?us-ascii?Q?hEfoUSuXLWQQ9NcvGHsVIwhsVJqTkbEOFykxG+6r0zUNlABGCaDc+LQeCsNh?=
 =?us-ascii?Q?pk9gSk/ftN2fzaPPb4casuhmntnOLZEYKB6mTKgBEHw48wAr2y5GjsaUq6WI?=
 =?us-ascii?Q?uFH9sV3Cg0o7v84SRC0x0svwE3+2PZOKmje4X3vugrujNleeAX/IGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X7y49KebPjMbgZVc0cUUJrKZA5yP0Ols64cfaSlIwVKRn00w2nF6PDc9IQmI?=
 =?us-ascii?Q?3+cMIgX3SEibbVOqLIi2A1p1gSd1Q4UPN4ShWNPfVZBD2f4LshPo6LPgBDi1?=
 =?us-ascii?Q?ZPpEQa2R40qtojP8cDBCP0R9/IejbeY8xbWdCsmyuJuB8v7IEaX7hXtvRLUm?=
 =?us-ascii?Q?JUTuEHiRR5j3Sb03HrpcR9ubAq1z3teDyM4Iy5uXq6qyzMRTAI6G+rgg8733?=
 =?us-ascii?Q?WLeUx9Ja7JB6cLQmLlq7kDyW2jmvW3M9YnOn3HVySdhnjZpGzWRq0RIRAffY?=
 =?us-ascii?Q?Vrybm+5Un1QOJp2T91ltHfWxkzn/ImRgNWb4EWx8aysxujfdUjqqNcadAjgx?=
 =?us-ascii?Q?/dPxH6SMWFcUKzdbEEve7RhJcDpqYPGSboX9LeUqXXDFF4jOhWUAc1pAcI43?=
 =?us-ascii?Q?85ohkGilGd4TWhTyW3on8KQUEChcbPRdXBQGx0DTLSDBNV83Sdncs1g1oBQi?=
 =?us-ascii?Q?7PkrxDzmbN67C0Guxre0sHLi/hwF9RgHqJBskZ2/4mJp2Uy9vFu4gQbtGs0e?=
 =?us-ascii?Q?PGuAklwQ020RC57bqp4+d5rsyVQypPjlFakfx2glbRS1eVljkgFInjfWcfkG?=
 =?us-ascii?Q?qiPAJEYp7iXL2i9J2Se9mxwvRmyb5FNYOz1D4uDB+BkWYwnV25fpYM5NSWeK?=
 =?us-ascii?Q?ILkFyXk1t5S2whgQGxf1Hhl9J8t9hCdvE+n9x3UKFQWo2FIbCqEw/BTi5zMx?=
 =?us-ascii?Q?YIlVSJ0MsEk4dhTPArdZAP8fhZY/RhSee4Eizj8M4vOk2cS1gkPKN7rdzogR?=
 =?us-ascii?Q?UGSRVjWBfHBUYpwqwe5cW6SITUBSkmWXwB4SGyi8IenGRdIKxDsaDRL7PUIe?=
 =?us-ascii?Q?Kt5O0HU2/OFQ3JItNWd5mlUmbi3f++4464vnW7sX2mIv/Y2Z1pXKLmgB0458?=
 =?us-ascii?Q?a+2MOPM4F8Mzi3Dw15Gh0jISX1hx6/bkM0KKK39pXUTF3LXXUCZ71ZbRJZDb?=
 =?us-ascii?Q?L5pLWW7siZQ5xbBCr4sHwsfBPes4k6mcG+6RTUbbhQ8x8ZCg5jzeP2/MrcVm?=
 =?us-ascii?Q?j1J9iP7WwCX/EeGjiF5jovxpeqf0dZqo/Vm6e/34HJro/VbcKmw+uLpmTlq3?=
 =?us-ascii?Q?XFZhmmogHFvu9QIYJMEWlI8COLwC81At5H7ssDbucs2MUYeeK1vwHiiuONQ5?=
 =?us-ascii?Q?4cSAGiUmlcy/h4Q07RHvsdva/DbM6eYDXhByvNpAChQCtMB9YBDFB/mfaCEe?=
 =?us-ascii?Q?eEGnNxWqhHgY78sFeyBSMRDjnowCk8coloJLXNNE9A+9uTx4IU83wh8+cnOk?=
 =?us-ascii?Q?t43zUyjoIcQKQlrV3tVikqerLmJd9kEiwa0QLnGTJdYbGm8zwL/lfW+zHcBx?=
 =?us-ascii?Q?PUQrrfB7uMMg/LG1EHwWktSsP91CAFh6mgEgsOBhp/zKGYP8EqFwQb6sbpCj?=
 =?us-ascii?Q?YrETbOcK4N4kM8PAPdTUptUbaL41H2QdPZZ3uKYbJO8Dn9gpQT3pDo7ugFL1?=
 =?us-ascii?Q?ofdQbhcOCUaq9VcucZymQVs/L/KDFfUfVoVMTddyr2UzAqmL4glQiG3JbhIX?=
 =?us-ascii?Q?gn2m4B/IDBAJn7rYeq5/oE/B0w0AamTVOg3O7/w1yuwEceX7WDZvylRuVGpC?=
 =?us-ascii?Q?iaUTx7pOVkve6dTo+EE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967370CC03FF295A6E5BC199DB42SJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c648333-5e19-4698-3c8a-08dd774b1a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 09:44:20.2788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJKQlsmR/OvJnOOp4HZBUZW+9LGm5Sgy2egg2Ogy/IbbFp0THZj0Jy1Jf+vhxZvT7dVNg/oqxRJYDUquNZUraA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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

--_000_SJ0PR12MB6967370CC03FF295A6E5BC199DB42SJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Dan Carpenter,

Thank you for your review, there is indeed a problem with NULL Pointers, I =
will correct this problem immediately





Regards,
Sun,Ce
________________________________
From: Dan Carpenter <dan.carpenter@linaro.org>
Sent: Wednesday, April 9, 2025 4:46 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: Multi-GPU DPC recovery support

Hello Ce Sun,

Commit 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
from Mar 21, 2025 (linux-next), leads to the following Smatch static
checker warning:

        drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_res=
et()
        warn: iterator used outside loop: 'tmp_adev'

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    6753 pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
    6754 {
    6755         struct drm_device *dev =3D pci_get_drvdata(pdev);
    6756         struct amdgpu_device *adev =3D drm_to_adev(dev);
    6757         struct amdgpu_reset_context reset_context;
    6758         struct amdgpu_device *tmp_adev =3D NULL;
    6759         struct amdgpu_hive_info *hive =3D NULL;
    6760         struct list_head device_list;
    6761         int r =3D 0, i;
    6762         u32 memsize;
    6763
    6764         /* PCI error slot reset should be skipped During RAS recov=
ery */
    6765         if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION=
(9, 4, 3) ||
    6766             amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(=
9, 4, 4)) &&
    6767             amdgpu_ras_in_recovery(adev))
    6768                 return PCI_ERS_RESULT_RECOVERED;
    6769
    6770         dev_info(adev->dev, "PCI error: slot reset callback!!\n");
    6771
    6772         memset(&reset_context, 0, sizeof(reset_context));
    6773
    6774         /* wait for asic to come out of reset */
    6775         msleep(700);
    6776
    6777         /* Restore PCI confspace */
    6778         amdgpu_device_load_pci_state(pdev);
    6779
    6780         /* confirm  ASIC came out of reset */
    6781         for (i =3D 0; i < adev->usec_timeout; i++) {
    6782                 memsize =3D amdgpu_asic_get_config_memsize(adev);
    6783
    6784                 if (memsize !=3D 0xffffffff)
    6785                         break;
    6786                 udelay(1);
    6787         }
    6788         if (memsize =3D=3D 0xffffffff) {
    6789                 r =3D -ETIME;
    6790                 goto out;
    6791         }
    6792
    6793         reset_context.method =3D AMD_RESET_METHOD_NONE;
    6794         reset_context.reset_req_dev =3D adev;
    6795         set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
    6796         set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
    6797         INIT_LIST_HEAD(&device_list);
    6798
    6799         hive =3D amdgpu_get_xgmi_hive(adev);
    6800         if (hive) {
    6801                 mutex_lock(&hive->hive_lock);
    6802                 reset_context.hive =3D hive;
    6803                 list_for_each_entry(tmp_adev, &hive->device_list, =
gmc.xgmi.head) {
    6804                         tmp_adev->pcie_reset_ctx.in_link_reset =3D=
 true;
    6805                         list_add_tail(&tmp_adev->reset_list, &devi=
ce_list);
    6806                 }

tmp_adev is an invalid non-NULL pointer.

    6807         } else {
    6808                 set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags=
);
    6809                 list_add_tail(&adev->reset_list, &device_list);
    6810         }
    6811
    6812         r =3D amdgpu_device_asic_reset(adev, &device_list, &reset_=
context);
    6813 out:
    6814         if (!r) {
    6815                 if (amdgpu_device_cache_pci_state(adev->pdev))
    6816                         pci_restore_state(adev->pdev);
    6817                 dev_info(adev->dev, "PCIe error recovery succeeded=
\n");
    6818         } else {
    6819                 dev_err(adev->dev, "PCIe error recovery failed, er=
r:%d\n", r);
--> 6820                 if (tmp_adev) {

This looks like it might have been intentional but it would be more
readable to check if (hive) {

    6821                         list_for_each_entry(tmp_adev, &device_list=
, reset_list)
    6822                                 amdgpu_device_unset_mp1_state(tmp_=
adev);
    6823                         amdgpu_device_unlock_reset_domain(adev->re=
set_domain);
    6824                 }
    6825         }
    6826
    6827         if (hive) {
    6828                 mutex_unlock(&hive->hive_lock);
    6829                 amdgpu_put_xgmi_hive(hive);
    6830         }
    6831
    6832         return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECO=
VERED;
    6833 }

regards,
dan carpenter

--_000_SJ0PR12MB6967370CC03FF295A6E5BC199DB42SJ0PR12MB6967namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Dan Carpenter,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you for your review, there is indeed a problem with NULL Pointers, I =
will correct this problem immediately</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,<br>
Sun,Ce</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter@linaro.org&gt;<br>
<b>Sent:</b> Wednesday, April 9, 2025 4:46 PM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Subject:</b> [bug report] drm/amdgpu: Multi-GPU DPC recovery support</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello Ce Sun,<br>
<br>
Commit 8ba904f54148 (&quot;drm/amdgpu: Multi-GPU DPC recovery support&quot;=
)<br>
from Mar 21, 2025 (linux-next), leads to the following Smatch static<br>
checker warning:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgp=
u_device.c:6820 amdgpu_pci_slot_reset()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warn: iterator used outside loop=
: 'tmp_adev'<br>
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&nbsp;&nbsp;&nbsp; 6753 pci_ers_result_t amdgpu_pci_slot_reset(struct pci_d=
ev *pdev)<br>
&nbsp;&nbsp;&nbsp; 6754 {<br>
&nbsp;&nbsp;&nbsp; 6755&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct drm_device *dev =3D pci_get_drvdata(pdev);<br>
&nbsp;&nbsp;&nbsp; 6756&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_device *adev =3D drm_to_adev(dev);<br>
&nbsp;&nbsp;&nbsp; 6757&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_reset_context reset_context;<br>
&nbsp;&nbsp;&nbsp; 6758&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_device *tmp_adev =3D NULL;<br>
&nbsp;&nbsp;&nbsp; 6759&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_hive_info *hive =3D NULL;<br>
&nbsp;&nbsp;&nbsp; 6760&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct list_head device_list;<br>
&nbsp;&nbsp;&nbsp; 6761&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 r =3D 0, i;<br>
&nbsp;&nbsp;&nbsp; 6762&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32=
 memsize;<br>
&nbsp;&nbsp;&nbsp; 6763 <br>
&nbsp;&nbsp;&nbsp; 6764&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
PCI error slot reset should be skipped During RAS recovery */<br>
&nbsp;&nbsp;&nbsp; 6765&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
&nbsp;&nbsp;&nbsp; 6766&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(=
9, 4, 4)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp; 6767&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; amdgpu_ras_in_recovery(adev))<br>
&nbsp;&nbsp;&nbsp; 6768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PCI_ERS_RESULT_RECOVERE=
D;<br>
&nbsp;&nbsp;&nbsp; 6769 <br>
&nbsp;&nbsp;&nbsp; 6770&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev=
_info(adev-&gt;dev, &quot;PCI error: slot reset callback!!\n&quot;);<br>
&nbsp;&nbsp;&nbsp; 6771 <br>
&nbsp;&nbsp;&nbsp; 6772&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(&amp;reset_context, 0, sizeof(reset_context));<br>
&nbsp;&nbsp;&nbsp; 6773 <br>
&nbsp;&nbsp;&nbsp; 6774&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
wait for asic to come out of reset */<br>
&nbsp;&nbsp;&nbsp; 6775&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msl=
eep(700);<br>
&nbsp;&nbsp;&nbsp; 6776 <br>
&nbsp;&nbsp;&nbsp; 6777&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Restore PCI confspace */<br>
&nbsp;&nbsp;&nbsp; 6778&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_device_load_pci_state(pdev);<br>
&nbsp;&nbsp;&nbsp; 6779 <br>
&nbsp;&nbsp;&nbsp; 6780&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
confirm&nbsp; ASIC came out of reset */<br>
&nbsp;&nbsp;&nbsp; 6781&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=
 (i =3D 0; i &lt; adev-&gt;usec_timeout; i++) {<br>
&nbsp;&nbsp;&nbsp; 6782&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memsize =3D amdgpu_asic_get_co=
nfig_memsize(adev);<br>
&nbsp;&nbsp;&nbsp; 6783 <br>
&nbsp;&nbsp;&nbsp; 6784&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (memsize !=3D 0xffffffff)<b=
r>
&nbsp;&nbsp;&nbsp; 6785&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp; 6786&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(1);<br>
&nbsp;&nbsp;&nbsp; 6787&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; 6788&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(memsize =3D=3D 0xffffffff) {<br>
&nbsp;&nbsp;&nbsp; 6789&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -ETIME;<br>
&nbsp;&nbsp;&nbsp; 6790&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;&nbsp;&nbsp; 6791&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; 6792 <br>
&nbsp;&nbsp;&nbsp; 6793&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res=
et_context.method =3D AMD_RESET_METHOD_NONE;<br>
&nbsp;&nbsp;&nbsp; 6794&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res=
et_context.reset_req_dev =3D adev;<br>
&nbsp;&nbsp;&nbsp; 6795&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set=
_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context.flags);<br>
&nbsp;&nbsp;&nbsp; 6796&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set=
_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context.flags);<br>
&nbsp;&nbsp;&nbsp; 6797&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INI=
T_LIST_HEAD(&amp;device_list);<br>
&nbsp;&nbsp;&nbsp; 6798 <br>
&nbsp;&nbsp;&nbsp; 6799&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hiv=
e =3D amdgpu_get_xgmi_hive(adev);<br>
&nbsp;&nbsp;&nbsp; 6800&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(hive) {<br>
&nbsp;&nbsp;&nbsp; 6801&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hive-&gt;hive_=
lock);<br>
&nbsp;&nbsp;&nbsp; 6802&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context.hive =3D hive;<b=
r>
&nbsp;&nbsp;&nbsp; 6803&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, =
&amp;hive-&gt;device_list, gmc.xgmi.head) {<br>
&nbsp;&nbsp;&nbsp; 6804&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; tmp_adev-&gt;pcie_reset_ctx.in_link_reset =3D true;<br>
&nbsp;&nbsp;&nbsp; 6805&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; list_add_tail(&amp;tmp_adev-&gt;reset_list, &amp;device_l=
ist);<br>
&nbsp;&nbsp;&nbsp; 6806&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
tmp_adev is an invalid non-NULL pointer.<br>
<br>
&nbsp;&nbsp;&nbsp; 6807&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&nbsp;&nbsp;&nbsp; 6808&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_SKIP_HW_RESET, =
&amp;reset_context.flags);<br>
&nbsp;&nbsp;&nbsp; 6809&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;adev-&gt;re=
set_list, &amp;device_list);<br>
&nbsp;&nbsp;&nbsp; 6810&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; 6811 <br>
&nbsp;&nbsp;&nbsp; 6812&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_device_asic_reset(adev, &amp;device_list, &amp;reset_context);<b=
r>
&nbsp;&nbsp;&nbsp; 6813 out:<br>
&nbsp;&nbsp;&nbsp; 6814&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!r) {<br>
&nbsp;&nbsp;&nbsp; 6815&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_cache_pci_st=
ate(adev-&gt;pdev))<br>
&nbsp;&nbsp;&nbsp; 6816&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pci_restore_state(adev-&gt;pdev);<br>
&nbsp;&nbsp;&nbsp; 6817&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;P=
CIe error recovery succeeded\n&quot;);<br>
&nbsp;&nbsp;&nbsp; 6818&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&nbsp;&nbsp;&nbsp; 6819&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;PC=
Ie error recovery failed, err:%d\n&quot;, r);<br>
--&gt; 6820&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_adev) {<br>
<br>
This looks like it might have been intentional but it would be more<br>
readable to check if (hive) {<br>
<br>
&nbsp;&nbsp;&nbsp; 6821&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, &amp;device_list, reset_lis=
t)<br>
&nbsp;&nbsp;&nbsp; 6822&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_de=
vice_unset_mp1_state(tmp_adev);<br>
&nbsp;&nbsp;&nbsp; 6823&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_device_unlock_reset_domain(adev-&gt;reset_domain);=
<br>
&nbsp;&nbsp;&nbsp; 6824&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; 6825&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; 6826 <br>
&nbsp;&nbsp;&nbsp; 6827&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(hive) {<br>
&nbsp;&nbsp;&nbsp; 6828&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hive-&gt;hiv=
e_lock);<br>
&nbsp;&nbsp;&nbsp; 6829&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_put_xgmi_hive(hive);<br=
>
&nbsp;&nbsp;&nbsp; 6830&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; 6831 <br>
&nbsp;&nbsp;&nbsp; 6832&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;<br>
&nbsp;&nbsp;&nbsp; 6833 }<br>
<br>
regards,<br>
dan carpenter<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB6967370CC03FF295A6E5BC199DB42SJ0PR12MB6967namp_--
