Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A071CD6E60
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 12:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB6910F003;
	Tue,  2 Jun 2026 12:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jrxpva9r";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECE310F003
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 12:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q55r3wTP9eiZenRR5bCqH7lNxSQBtn0PqrqyUfMh0iCwWeto+T39IgY9HBuOAXG9YxxnIK6TLPXaAJ86RiX6Vxi746xPtMeKqfiCsZ5jwW00YBMm+7L/3O4waMwLTlqKHBJIwkJO948ouIyTWIEZJyN1sid8NW/uXpwMmLEgxUTrK2YCheBAcQTty2zMWhKVCr0fkDh3I2aXmjtdJu3nxMqOMsev8UNTauBKDPhPGc5N+4B+NKyVxnFGVoGCGu2T+i+WLNjbX4iKfWbzDW9xaYFbz7cL+aKpLlQfYoax3S1PrcE8uc5SZSVtUc/UlV3kA5SFR1pKG5V/vXh+4jzCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQFBXBcp5isVHwwc3W+hs3eeVNyTSRI28UkgiCzL2t8=;
 b=LXDig6Wlpf4gl/PlSWqzxbg/7RVlSO6lpjOtGozpq8acpKWzJlSGDqLQU2G1UKcQUL6YbGsk5WF47mc+pvRGS21yxNTtkw/lerfnTYeoxBbELbAVz9yVNldglRxNK9EId7sy7/jQ0uGYdE/e7GQ7KxSMCm+rS5O2Vi47LAnEYTafN0CG+pSfm/KrsoQY5OWdQKmECMQryrdGi1sjMFG3XqW8BoFzzGJa99RQU/fbXDWMWm0apYzpq5gNGXzWvFEhCTKehP+4Z96gXWs7m6KatH5K0jvAgaIXKMmGOKEs/ImSZ4qfz4aqjcuJUx3C4QMKAf0bMuTk6PyBm0vMiZKMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQFBXBcp5isVHwwc3W+hs3eeVNyTSRI28UkgiCzL2t8=;
 b=Jrxpva9rnsmuFdKHTdo7ccLZCy5kJU4mpI1V7Hs/RDq3e9V218AmoOqi+977ipipUJBc02Fqom234FbuMr1L9H3jvQPr6mS77aPunAlB5dzm3jKkKdhTSv1T26zuSln8PUv+puAEiKct7dHRjHkG7P4Wp9nHn560OkjjwcY6t08=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 12:02:09 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 12:02:09 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Thread-Topic: [PATCH] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Thread-Index: AQHc7zKzCGSThaVocECZRh4yh2pHYrYrMNrQ
Date: Tue, 2 Jun 2026 12:02:09 +0000
Message-ID: <DM4PR12MB503864C2971265F7305041058E122@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260529061607.356352-1-asad.kamal@amd.com>
In-Reply-To: <20260529061607.356352-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-02T12:02:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|PH7PR12MB7305:EE_
x-ms-office365-filtering-correlation-id: 07455147-41c6-4a7d-2053-08dec09ec5fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|3023799007|56012099006|11063799006;
x-microsoft-antispam-message-info: 1WDeX7wBXed9YLphgtFKJXv69qv0dX0NzPvODmZieNIZ+hgVTT5Er4/KXCay1k+PAp1fl4plOvofkg4/sX4LJuCxLrlCKj3bF6JG15AdD4lcxW7tGWTO098fQsVsgrJW29EHVPvXA8J774rSHUhq58o+j9bqRjvV1KlTHefg6OP3cv461PiYTxyY7l1I0ZBctB90HVUS1UVTTSo16HqNZfkQvxxA80CD3XcPVD9XMscHimQjvPXzk3OhW6hDKEBOpxpttcyD29aThrGYXz37MnnuLa2PCRyxkVSJ+nOA9xq7RVsjXe8IgM1yrcRzhToTsHgE3jBENHyNIa+oZRZlPq3Qdk6xif2l5jfJxb+JscXYkFnKEhcj9BApQQkYQt1AFhNO6udrWDnBNkye7onO0kC5IgCVjGiDZJ6XVHfHHpfieEPHEGdnDhNnubx120y9zvO01o2ZVLF73a9xVcaecX6FO94WHuERGliKj3aj6EayS3w3epvVFSyUzOSc7uGui84Q3L1Os3av+wuHVdP+sgYu/mbkiMArJq0LHDoY6SfzVwg5tR3SDySqihpA5hUWv5Z7CWi2aVSHX+NZdLpGjo0HNqylnmHl/2XNHBzIPirxP9Gzht9bh7X89KW0X+ScTpcfMMCvO2WcybkxJxc9K7VwbbQWIlyXdXKJXQFwv4CJsnZiWmX+rhagg/pZccGehsIDn0Lv/FWj8uyktpCIoGwD4eNE1z9WMY3eJtY5nWx/GYJAmtPvuqk87Rp4Vlq+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OOnyiPJyUT0hoqglQ2RtJKEoouha0aaBVSftdiaxtf5aJ4+pkJUz0pfekxjf?=
 =?us-ascii?Q?Y+7uecDl+OvYPdHXZXWTjuZJAE6FENkaf8J8hgZKmtztEA3PB4chtBBSZX9V?=
 =?us-ascii?Q?L2wsT7uT31C6UCGq/feUf2uv1xxaeAsRRDDSQFL4SmqVgzLQi0o7GvSozzml?=
 =?us-ascii?Q?6JlkNU1bBGB6OgdXrktOBCIRgpQh/Ssou3yLXdig8IoGFbpZxFI9CpW13MgO?=
 =?us-ascii?Q?9ljXcNPeI1pA8/bNJGU36lr5L8BEEFUxi8DbpbC+cEf5peevmJI718hmPN0H?=
 =?us-ascii?Q?+Ljc8M60aZFMzdM0EruMCByVazs8iIr5+ImKYu28N8rrh9BKjfvlScPHtBsU?=
 =?us-ascii?Q?JMQ9NAF7fMZIu6i12D0Sbpl8Pt93IcfjeKMg3JZD6VTYhjlvXe8vfS5Lwq3Z?=
 =?us-ascii?Q?SAFaM3IQgngZkCg1689jXmlnIOpoaMtimMXk5lnyP1/eruoO23La4V53VZn0?=
 =?us-ascii?Q?2Wav2nh11v1IsmTe0jvC8MrEkUs5pXQxE6MpiIbB407jXzZv01ZYX24qkoRh?=
 =?us-ascii?Q?mxgQJARzwMaaWqSrUrX6hXpOAQpNS+LcZ81Eo/thcR/wthv/gO2IudJrfhMR?=
 =?us-ascii?Q?RfJO593hADjuy3Nv3gsoqOrcp9aV8xOhZJyTjzDsSnks2rjg5y1Ojxvdi1Aa?=
 =?us-ascii?Q?VbCTtjpXtQ8jhgAZFuniops0fx1AJRa12SSPnpqtkIT9AL6O91H6NZL8Ku/7?=
 =?us-ascii?Q?HKOmSQIZ3J+oNoKbiD29WgtHpO8fK+krnhvXUHMxAlBC7wbDq0/MJJviTmbr?=
 =?us-ascii?Q?gI2RqOoZNGY0WgwDpm3/23eCoUUwXuAwshGXnUFbjHIhuUXlrblArloiPcEo?=
 =?us-ascii?Q?YmKHG8ZffNyEa9OgbCPYfYmvkR0qIHG3wWZ9sBam9+5nAbIf9EFxDLy/yJny?=
 =?us-ascii?Q?aZ91ci/EKce4Gm9cJxXzmgM+dIVvqo4u85TqYdRX+FxhG+1Fw7mhWgwl2Ka7?=
 =?us-ascii?Q?SBoMpS2Lpfpjs8TqHog1A3rNP9izhxfe7n9UUMSRNXzKao8lhvImWRwhzIJl?=
 =?us-ascii?Q?uuqTTLCVgjVDEkvjqDBrNaFGUlsxL2swbQqvzBsG0QTrL8NdcWzdHerNjSGD?=
 =?us-ascii?Q?FFzUm9Qb3bm6X4lmPOQ3l10t5+bTFzmSS9/1VIZAA1YMvFqSveMOzRZPIXY9?=
 =?us-ascii?Q?TLuNOuOimC0QlbHupGogSLwTlQ0Yvw1P/zXIk3SI7Y6DzmVSfHdgvbZshoFp?=
 =?us-ascii?Q?a3MjxjqUJVe/08fdwVGW1vbLAT1p4pjBiD3rafj7HJSZO+rau/wpiYy+xgdg?=
 =?us-ascii?Q?5H2x2wFMLuvyjh+tM4X1tZq6uC6dpNYEiF+wY0jKjuo9YlhIhyvIPteGNNcp?=
 =?us-ascii?Q?ie/JvQGSG3A10OCm293N9nepig6RaQzIs+jPgZLv/ma3rISfTq8wOC805zk9?=
 =?us-ascii?Q?U8YQo0ODt4WxE2NQzZ0TTmDkaGjyR5HS5UT1hA9ak7ApU7lH2L/QVyFpnok6?=
 =?us-ascii?Q?K4FZSvZiSnWI2L+z3SqofBqUOHXSXRIqyDCmj9KkrzrKIiR3dzreJkbeRhvZ?=
 =?us-ascii?Q?Oa/PE1CG1J1F86HOn68A82/GGVgdEM+2rdwbkM6bLFKTo84MIxheTGf6DTaO?=
 =?us-ascii?Q?wpIXRpkB2dXuygX6aL7yMvq+byia7YwVA640UFZzJGIumURefCvO4kamnRFw?=
 =?us-ascii?Q?L5GIjEB+EP9Zk+f7tZ9nzsbHMhgL+CW5eYYoUaFM0X7ZFnUlwz3isAw+rAa3?=
 =?us-ascii?Q?HJ2QtuEkXoS6tVp6WhOC+XPQ3JPhbGzx1Luk+QfzTb2tKhE9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07455147-41c6-4a7d-2053-08dec09ec5fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 12:02:09.2000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g395Tu30uk6sjt+sBfnDx24N47zYoQEteot6mZEwU2oAJ/OUT3UXHl8sKpDs+pJcEKsDnVmwmgr8HeJD0iJQJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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

AMD General

ping

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, May 29, 2026 11:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown

amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow arbitrary MMIO r=
ead/write via RREG32/WREG32 without checking security_locked_down().
On kernel_lockdown=3Dintegrity systems this bypasses the same restrictions =
as /dev/mem and PCI config space sysfs.

Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every debugf=
s handler that performs direct register access.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 58 +++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 0ce6e2e4342c..c1f22b0985d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -25,6 +25,7 @@

 #include <linux/kthread.h>
 #include <linux/pci.h>
+#include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>

@@ -43,6 +44,11 @@

 #if defined(CONFIG_DEBUG_FS)

+static int amdgpu_debugfs_lockdown_mmio(void)
+{
+       return security_locked_down(LOCKDOWN_PCI_ACCESS);
+}
+
 /**
  * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
  *
@@ -86,6 +92,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, str=
uct file *f,
                        ((*pos & (1ULL << 62)) && (*pos & (1ULL << 61))))
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        /* are we reading registers for which a PG lock is necessary? */
        pm_pg_lock =3D (*pos >> 23) & 1;

@@ -237,6 +247,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f,=
 char __user *buf, u32 off
        if (size & 0x3 || offset & 0x3)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -402,6 +416,10 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file=
 *f, char __user *buf, siz
        if (size > 4096 || size & 0x3 || *pos & 0x3)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -521,6 +539,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct fi=
le *f, char __user *buf,
        if (size & 0x3 || *pos & 0x3)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -580,6 +602,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct f=
ile *f, const char __user
        if (size & 0x3 || *pos & 0x3)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -635,6 +661,10 @@ static ssize_t amdgpu_debugfs_regs_pcie64_read(struct =
file *f, char __user *buf,
        if (size & 0x7 || *pos & 0x7)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -687,6 +717,10 @@ static ssize_t amdgpu_debugfs_regs_pcie64_write(struct=
 file *f, const char __use
        if (size & 0x7 || *pos & 0x7)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -746,6 +780,10 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct fi=
le *f, char __user *buf,
        if (!adev->reg.didt.rreg)
                return -EOPNOTSUPP;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -804,6 +842,10 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct f=
ile *f, const char __user
        if (!adev->reg.didt.wreg)
                return -EOPNOTSUPP;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -863,6 +905,10 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct fil=
e *f, char __user *buf,
        if (size & 0x3 || *pos & 0x3)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -921,6 +967,10 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct fi=
le *f, const char __user *
        if (size & 0x3 || *pos & 0x3)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
        if (r < 0) {
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -1156,6 +1206,10 @@ static ssize_t amdgpu_debugfs_wave_read(struct file =
*f, char __user *buf,
        if (size & 3 || *pos & 3)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        /* decode offset */
        offset =3D (*pos & GENMASK_ULL(6, 0));
        se =3D (*pos & GENMASK_ULL(14, 7)) >> 7; @@ -1247,6 +1301,10 @@ sta=
tic ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
        if (size > 4096 || size & 3 || *pos & 3)
                return -EINVAL;

+       r =3D amdgpu_debugfs_lockdown_mmio();
+       if (r)
+               return r;
+
        /* decode offset */
        offset =3D (*pos & GENMASK_ULL(11, 0)) >> 2;
        se =3D (*pos & GENMASK_ULL(19, 12)) >> 12;
--
2.46.0

