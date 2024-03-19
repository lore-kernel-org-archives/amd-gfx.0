Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA80C54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 09:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717CF10F89A;
	Tue, 19 Mar 2024 09:00:24 +0000 (UTC)
X-Greylist: delayed 1188 seconds by postgrey-1.36 at gabe;
 Tue, 19 Mar 2024 01:54:56 UTC
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA1810E20D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 01:54:55 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TzDkC3xRJz1Q9nH;
 Tue, 19 Mar 2024 09:32:51 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
 by mail.maildlp.com (Postfix) with ESMTPS id C14991400F4;
 Tue, 19 Mar 2024 09:35:05 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 09:35:04 +0800
Subject: Re: [linux-next:master] BUILD REGRESSION
 2e93f143ca010a5013528e1cfdc895f024fe8c21
To: kernel test robot <lkp@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>
CC: Linux Memory Management List <linux-mm@kvack.org>,
 <amd-gfx@lists.freedesktop.org>, <bpf@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <linux-omap@vger.kernel.org>,
 <netdev@vger.kernel.org>
References: <202403182219.XrvfZx4s-lkp@intel.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e7ca3f69-7052-616b-68db-f29a66b42edc@huawei.com>
Date: Tue, 19 Mar 2024 09:35:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202403182219.XrvfZx4s-lkp@intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-Mailman-Approved-At: Tue, 19 Mar 2024 09:00:19 +0000
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

ÔÚ 2024/3/18 22:33, kernel test robot Ð´µÀ:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 2e93f143ca010a5013528e1cfdc895f024fe8c21  Add linux-next specific files for 20240318
> 
> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- arc-allmodconfig
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- arc-allyesconfig
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- arm-allmodconfig
> |   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
> |   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- arm-allyesconfig
> |   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
> |   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- arm64-defconfig
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- csky-allmodconfig
> |   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- csky-allyesconfig
> |   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead

Hi, Richard,
I sent out the warning fix patch in 
https://patchwork.ozlabs.org/project/linux-mtd/patch/20240227024204.1080739-1-chengzhihao1@huawei.com/
