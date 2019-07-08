From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [1/2] drm/amd/powerplay: smu_v11_0: fix uninitialized variable use
Date: Mon, 8 Jul 2019 17:58:15 +0200
Message-ID: <CAK8P3a0hR2+g+vxKqm=a8DgPcNrBaqa3sbuEHuVzaw9Fryd4Zg@mail.gmail.com>
References: <20190708140816.1334640-1-arnd@arndb.de> <20190708150255.GA32266@archlinux-epyc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708150255.GA32266@archlinux-epyc>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Chengming Gui <Jack.Gui@amd.com>, Kevin Wang <kevin1.wang@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 8, 2019 at 5:02 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Mon, Jul 08, 2019 at 04:07:58PM +0200, Arnd Bergmann wrote:
> >       /* if don't has GetDpmClockFreq Message, try get current clock by SmuMetrics_t */
> > -     if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0)
> > +     if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0) {
> >               ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
> > -     else {
> > +             if (ret)
> > +                     return ret;
>
> I am kind of surprised that this fixes the warning. If I am interpreting
> the warning correctly, it is complaining that the member
> get_current_clk_freq_by_table could be NULL and not be called to
> initialize freq and that entire statement will become 0. If that is the
> case, it seems like this added error handling won't fix that problem,
> right?

No, I'm fairly sure this is the right fix. Looking at the whole function:

| static int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
|                                          enum smu_clk_type clk_id,
|                                          uint32_t *value)
|{
|        int ret = 0;
|        uint32_t freq;
|
|        if (clk_id >= SMU_CLK_COUNT || !value)
|                return -EINVAL;
|
|        /* if don't has GetDpmClockFreq Message, try get current
clock by SmuMetrics_t */
|        if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0) {
|                ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);

Here &freq may or may not get initialized

|        } else {
|                ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmClockFreq,
|
(smu_clk_get_index(smu, clk_id) << 16));
|                if (ret)
|                        return ret;
|
|               ret = smu_read_smc_arg(smu, &freq);
|                if (ret)
|                        return ret;

Same here, but if it's not initialized, we bail out

|        }
|
|       freq *= 100;
|        *value = freq;

And here it gets assigned to *value

|        return ret;
|}

    Arnd
