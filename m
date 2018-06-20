From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/amd/pp: Fix wrong clock-unit exported to Display
Date: Wed, 20 Jun 2018 11:19:55 -0400
Message-ID: <CADnq5_Nt4gFEKDf-zuzMdnu-1L5+mmTL9e0pgwuckn0Mysy7AA@mail.gmail.com>
References: <20180619211732.10012-1-harry.wentland@amd.com>
 <20180619211732.10012-3-harry.wentland@amd.com>
 <CADnq5_MubdXkZHwP982PvHLfrwCQo4KvFzk8egTdK4RGuCkY4g@mail.gmail.com>
 <CY4PR12MB1687C87330C2D926DD39BC94FB770@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1353780719=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687C87330C2D926DD39BC94FB770-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "Laktyushkin, Dmytro" <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, "Wu,
 Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1353780719==
Content-Type: multipart/alternative; boundary="000000000000c4e8d2056f1454d1"

--000000000000c4e8d2056f1454d1
Content-Type: text/plain; charset="UTF-8"

Yes, understood.  I just wanted to make sure we didn't merge both and break
things.

Alex


On Wed, Jun 20, 2018 at 10:51 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Alex,
>
>
> Mikita's patch was still not in drm-next.
>
> I reviewed the interfaces between powerplay and display.
>
> Most of them were still not implemented. so the services powerplay
> exported to dc will not be called.
>
> I tried to implement them.
>
> and then we can  try to test  the strutter mode on raven in linux.
>
>
> Best Regards
>
> Rex
>
>
> ------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Wednesday, June 20, 2018 11:47 AM
> *To:* Wentland, Harry
> *Cc:* amd-gfx list; Wu, Hersen; Lipski, Mikita; Laktyushkin, Dmytro; Zhu,
> Rex
> *Subject:* Re: [PATCH 2/5] drm/amd/pp: Fix wrong clock-unit exported to
> Display
>
> On Tue, Jun 19, 2018 at 5:17 PM, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> wrote:
> > From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> >
> > Transfer 10KHz (requested by smu) to KHz needed by Display
> > component.
> >
> > This can fix the issue 4k Monitor can't be lit up on Vega/Raven.
> >
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> Need to make sure we drop Mikita's patch if we apply this one
> otherwise the clocks will be wrong again.
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |  4 ++--
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 10 +++++-----
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 10 +++++-----
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > index d4bc83e81389..c905df42adc5 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > @@ -993,7 +993,7 @@ static int smu10_get_clock_by_type_with_latency(struct
> pp_hwmgr *hwmgr,
> >
> >         clocks->num_levels = 0;
> >         for (i = 0; i < pclk_vol_table->count; i++) {
> > -               clocks->data[i].clocks_in_khz =
> pclk_vol_table->entries[i].clk;
> > +               clocks->data[i].clocks_in_khz =
> pclk_vol_table->entries[i].clk * 10;
> >                 clocks->data[i].latency_in_us = latency_required ?
> >
> smu10_get_mem_latency(hwmgr,
> >
> pclk_vol_table->entries[i].clk) :
> > @@ -1044,7 +1044,7 @@ static int smu10_get_clock_by_type_with_voltage(struct
> pp_hwmgr *hwmgr,
> >
> >         clocks->num_levels = 0;
> >         for (i = 0; i < pclk_vol_table->count; i++) {
> > -               clocks->data[i].clocks_in_khz =
> pclk_vol_table->entries[i].clk;
> > +               clocks->data[i].clocks_in_khz =
> pclk_vol_table->entries[i].clk  * 10;
> >                 clocks->data[i].voltage_in_mv =
> pclk_vol_table->entries[i].vol;
> >                 clocks->num_levels++;
> >         }
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > index 3b8d36df52e9..e9a8b527d481 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > @@ -4067,7 +4067,7 @@ static void vega10_get_sclks(struct pp_hwmgr
> *hwmgr,
> >         for (i = 0; i < dep_table->count; i++) {
> >                 if (dep_table->entries[i].clk) {
> >                         clocks->data[clocks->num_levels].clocks_in_khz =
> > -                                       dep_table->entries[i].clk;
> > +                                       dep_table->entries[i].clk * 10;
> >                         clocks->num_levels++;
> >                 }
> >         }
> > @@ -4104,7 +4104,7 @@ static void vega10_get_memclocks(struct pp_hwmgr
> *hwmgr,
> >                         clocks->data[clocks->num_levels].clocks_in_khz =
> >                         data->mclk_latency_table.entries
> >                         [data->mclk_latency_table.count].frequency =
> > -                                       dep_table->entries[i].clk;
> > +                                       dep_table->entries[i].clk * 10;
> >                         clocks->data[clocks->num_levels].latency_in_us =
> >                         data->mclk_latency_table.entries
> >                         [data->mclk_latency_table.count].latency =
> > @@ -4126,7 +4126,7 @@ static void vega10_get_dcefclocks(struct pp_hwmgr
> *hwmgr,
> >         uint32_t i;
> >
> >         for (i = 0; i < dep_table->count; i++) {
> > -               clocks->data[i].clocks_in_khz =
> dep_table->entries[i].clk;
> > +               clocks->data[i].clocks_in_khz =
> dep_table->entries[i].clk * 10;
> >                 clocks->data[i].latency_in_us = 0;
> >                 clocks->num_levels++;
> >         }
> > @@ -4142,7 +4142,7 @@ static void vega10_get_socclocks(struct pp_hwmgr
> *hwmgr,
> >         uint32_t i;
> >
> >         for (i = 0; i < dep_table->count; i++) {
> > -               clocks->data[i].clocks_in_khz =
> dep_table->entries[i].clk;
> > +               clocks->data[i].clocks_in_khz =
> dep_table->entries[i].clk * 10;
> >                 clocks->data[i].latency_in_us = 0;
> >                 clocks->num_levels++;
> >         }
> > @@ -4202,7 +4202,7 @@ static int vega10_get_clock_by_type_with_voltage(struct
> pp_hwmgr *hwmgr,
> >         }
> >
> >         for (i = 0; i < dep_table->count; i++) {
> > -               clocks->data[i].clocks_in_khz =
> dep_table->entries[i].clk;
> > +               clocks->data[i].clocks_in_khz =
> dep_table->entries[i].clk  * 10;
> >                 clocks->data[i].voltage_in_mv =
> (uint32_t)(table_info->vddc_lookup_table->
> >                                 entries[dep_table->entries[i].
> vddInd].us_vdd);
> >                 clocks->num_levels++;
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > index 782e2098824d..d685ce7f88cc 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > @@ -1576,7 +1576,7 @@ static int vega12_get_sclks(struct pp_hwmgr *hwmgr,
> >
> >         for (i = 0; i < ucount; i++) {
> >                 clocks->data[i].clocks_in_khz =
> > -                       dpm_table->dpm_levels[i].value * 100;
> > +                       dpm_table->dpm_levels[i].value * 1000;
> >
> >                 clocks->data[i].latency_in_us = 0;
> >         }
> > @@ -1608,7 +1608,7 @@ static int vega12_get_memclocks(struct pp_hwmgr
> *hwmgr,
> >
> >         for (i = 0; i < ucount; i++) {
> >                 clocks->data[i].clocks_in_khz =
> > -                       dpm_table->dpm_levels[i].value * 100;
> > +                       dpm_table->dpm_levels[i].value * 1000;
> >
> >                 clocks->data[i].latency_in_us =
> >                         data->mclk_latency_table.entries[i].latency =
> > @@ -1638,7 +1638,7 @@ static int vega12_get_dcefclocks(struct pp_hwmgr
> *hwmgr,
> >
> >         for (i = 0; i < ucount; i++) {
> >                 clocks->data[i].clocks_in_khz =
> > -                       dpm_table->dpm_levels[i].value * 100;
> > +                       dpm_table->dpm_levels[i].value * 1000;
> >
> >                 clocks->data[i].latency_in_us = 0;
> >         }
> > @@ -1666,7 +1666,7 @@ static int vega12_get_socclocks(struct pp_hwmgr
> *hwmgr,
> >
> >         for (i = 0; i < ucount; i++) {
> >                 clocks->data[i].clocks_in_khz =
> > -                       dpm_table->dpm_levels[i].value * 100;
> > +                       dpm_table->dpm_levels[i].value * 1000;
> >
> >                 clocks->data[i].latency_in_us = 0;
> >         }
> > @@ -1838,7 +1838,7 @@ static int vega12_print_clock_levels(struct
> pp_hwmgr *hwmgr,
> >                                 return -1);
> >                 for (i = 0; i < clocks.num_levels; i++)
> >                         size += sprintf(buf + size, "%d: %uMhz %s\n",
> > -                               i, clocks.data[i].clocks_in_khz / 100,
> > +                               i, clocks.data[i].clocks_in_khz / 1000,
> >                                 (clocks.data[i].clocks_in_khz == now) ?
> "*" : "");
> >                 break;
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following
> form. Use of all freedesktop.org lists is subject to our Code of Conduct.
>
>
>

--000000000000c4e8d2056f1454d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5ZZXMsIHVuZGVyc3Rvb2QuwqAgSSBqdXN0IHdhbnRlZCB0byBt
YWtlIHN1cmUgd2UgZGlkbiYjMzk7dCBtZXJnZSBib3RoIGFuZCBicmVhayB0aGluZ3MuPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5BbGV4PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFdlZCwgSnVu
IDIwLCAyMDE4IGF0IDEwOjUxIEFNLCBaaHUsIFJleCA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzpSZXguWmh1QGFtZC5jb20iIHRhcmdldD0iX2JsYW5rIj5SZXguWmh1QGFtZC5j
b208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3Bh
ZGRpbmctbGVmdDoxZXgiPg0KDQoNCg0KDQo8ZGl2IGRpcj0ibHRyIj4NCjxkaXYgaWQ9Im1fLTE3
NTAyMzg2ODcyMDAxMzQwNzBkaXZ0YWdkZWZhdWx0d3JhcHBlciIgc3R5bGU9ImZvbnQtc2l6ZTox
MnB0O2NvbG9yOiMwMDAwMDA7Zm9udC1mYW1pbHk6Q2FsaWJyaSxIZWx2ZXRpY2Esc2Fucy1zZXJp
ZiIgZGlyPSJsdHIiPg0KPHAgc3R5bGU9Im1hcmdpbi10b3A6MDttYXJnaW4tYm90dG9tOjAiPkhp
IEFsZXgsPC9wPg0KPHAgc3R5bGU9Im1hcmdpbi10b3A6MDttYXJnaW4tYm90dG9tOjAiPjxicj4N
CjwvcD4NCjxwIHN0eWxlPSJtYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowIj48c3BhbiBzdHls
ZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxIZWx2ZXRpY2Esc2Fucy1zZXJpZixFbW9qaUZvbnQsJnF1
b3Q7QXBwbGUgQ29sb3IgRW1vamkmcXVvdDssJnF1b3Q7U2Vnb2UgVUkgRW1vamkmcXVvdDssTm90
b0NvbG9yRW1vamksJnF1b3Q7U2Vnb2UgVUkgU3ltYm9sJnF1b3Q7LCZxdW90O0FuZHJvaWQgRW1v
amkmcXVvdDssRW1vamlTeW1ib2xzO2ZvbnQtc2l6ZToxNC42NjY3cHgiPk1pa2l0YSYjMzk7cyBw
YXRjaCB3YXMgc3RpbGzCoG5vdA0KIGluwqA8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTox
NC42NjY3cHgiPmRybS1uZXh0Ljwvc3Bhbj48L3A+DQo8cCBzdHlsZT0ibWFyZ2luLXRvcDowO21h
cmdpbi1ib3R0b206MCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxNC42NjY3cHgiPkkgcmV2aWV3
ZWQgdGhlIGludGVyZmFjZXMgYmV0d2VlbiBwb3dlcnBsYXkgYW5kIGRpc3BsYXkuPC9zcGFuPjwv
cD4NCjxwIHN0eWxlPSJtYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowIj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjE0LjY2NjdweCI+TW9zdCBvZiB0aGVtIHdlcmUgc3RpbGwgbm90IGltcGxlbWVu
dGVkLiBzbyB0aGUgc2VydmljZXMgcG93ZXJwbGF5IGV4cG9ydGVkIHRvIGRjwqB3aWxsIG5vdCBi
ZSBjYWxsZWQuwqA8L3NwYW4+PC9wPg0KPHAgc3R5bGU9Im1hcmdpbi10b3A6MDttYXJnaW4tYm90
dG9tOjAiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTQuNjY2N3B4Ij5JIHRyaWVkIHRvIGltcGxl
bWVudCB0aGVtLsKgPC9zcGFuPjwvcD4NCjxwIHN0eWxlPSJtYXJnaW4tdG9wOjA7bWFyZ2luLWJv
dHRvbTowIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0LjY2NjdweCI+YW5kIHRoZW4gd2UgY2Fu
IMKgdHJ5IHRvIHRlc3QgwqB0aGUgc3RydXR0ZXIgbW9kZSBvbiByYXZlbiBpbiBsaW51eC48L3Nw
YW4+PC9wPg0KPHAgc3R5bGU9Im1hcmdpbi10b3A6MDttYXJnaW4tYm90dG9tOjAiPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTQuNjY2N3B4Ij48YnI+DQo8L3NwYW4+PC9wPg0KPHAgc3R5bGU9Im1h
cmdpbi10b3A6MDttYXJnaW4tYm90dG9tOjAiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTQuNjY2
N3B4Ij5CZXN0IFJlZ2FyZHM8L3NwYW4+PC9wPg0KPHAgc3R5bGU9Im1hcmdpbi10b3A6MDttYXJn
aW4tYm90dG9tOjAiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTQuNjY2N3B4Ij5SZXg8L3NwYW4+
PC9wPg0KPGJyPg0KPGJyPg0KPGRpdiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKSI+DQo8aHIgc3R5
bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3dpZHRoOjk4JSI+DQo8ZGl2IGlkPSJtXy0xNzUwMjM4
Njg3MjAwMTM0MDcwZGl2UnBseUZ3ZE1zZyIgZGlyPSJsdHIiPjxmb250IHN0eWxlPSJmb250LXNp
emU6MTFwdCIgZmFjZT0iQ2FsaWJyaSwgc2Fucy1zZXJpZiIgY29sb3I9IiMwMDAwMDAiPjxiPkZy
b206PC9iPiBBbGV4IERldWNoZXIgJmx0OzxhIGhyZWY9Im1haWx0bzphbGV4ZGV1Y2hlckBnbWFp
bC5jb20iIHRhcmdldD0iX2JsYW5rIj5hbGV4ZGV1Y2hlckBnbWFpbC5jb208L2E+Jmd0Ozxicj4N
CjxiPlNlbnQ6PC9iPiBXZWRuZXNkYXksIEp1bmUgMjAsIDIwMTggMTE6NDcgQU08YnI+DQo8Yj5U
bzo8L2I+IFdlbnRsYW5kLCBIYXJyeTxicj4NCjxiPkNjOjwvYj4gYW1kLWdmeCBsaXN0OyBXdSwg
SGVyc2VuOyBMaXBza2ksIE1pa2l0YTsgTGFrdHl1c2hraW4sIERteXRybzsgWmh1LCBSZXg8YnI+
DQo8Yj5TdWJqZWN0OjwvYj4gUmU6IFtQQVRDSCAyLzVdIGRybS9hbWQvcHA6IEZpeCB3cm9uZyBj
bG9jay11bml0IGV4cG9ydGVkIHRvIERpc3BsYXk8L2ZvbnQ+DQo8ZGl2PsKgPC9kaXY+DQo8L2Rp
dj4NCjxkaXYgY2xhc3M9Im1fLTE3NTAyMzg2ODcyMDAxMzQwNzBCb2R5RnJhZ21lbnQiPjxmb250
IHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTFwdCI+DQo8ZGl2IGNsYXNzPSJtXy0x
NzUwMjM4Njg3MjAwMTM0MDcwUGxhaW5UZXh0Ij48ZGl2PjxkaXYgY2xhc3M9Img1Ij5PbiBUdWUs
IEp1biAxOSwgMjAxOCBhdCA1OjE3IFBNLCBIYXJyeSBXZW50bGFuZCAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmhhcnJ5LndlbnRsYW5kQGFtZC5jb20iIHRhcmdldD0iX2JsYW5rIj5oYXJyeS53ZW50bGFu
ZEBhbWQuY29tPC9hPiZndDsgd3JvdGU6PGJyPg0KJmd0OyBGcm9tOiBSZXggWmh1ICZsdDs8YSBo
cmVmPSJtYWlsdG86UmV4LlpodUBhbWQuY29tIiB0YXJnZXQ9Il9ibGFuayI+UmV4LlpodUBhbWQu
Y29tPC9hPiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0OyBUcmFuc2ZlciAxMEtIeiAocmVxdWVzdGVk
IGJ5IHNtdSkgdG8gS0h6IG5lZWRlZCBieSBEaXNwbGF5PGJyPg0KJmd0OyBjb21wb25lbnQuPGJy
Pg0KJmd0Ozxicj4NCiZndDsgVGhpcyBjYW4gZml4IHRoZSBpc3N1ZSA0ayBNb25pdG9yIGNhbiYj
Mzk7dCBiZSBsaXQgdXAgb24gVmVnYS9SYXZlbi48YnI+DQomZ3Q7PGJyPg0KJmd0OyBTaWduZWQt
b2ZmLWJ5OiBSZXggWmh1ICZsdDs8YSBocmVmPSJtYWlsdG86UmV4LlpodUBhbWQuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+UmV4LlpodUBhbWQuY29tPC9hPiZndDs8YnI+DQomZ3Q7IEFja2VkLWJ5OiBB
bGV4IERldWNoZXIgJmx0OzxhIGhyZWY9Im1haWx0bzphbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
IiB0YXJnZXQ9Il9ibGFuayI+YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbTwvYT4mZ3Q7PGJyPg0K
PGJyPg0KTmVlZCB0byBtYWtlIHN1cmUgd2UgZHJvcCBNaWtpdGEmIzM5O3MgcGF0Y2ggaWYgd2Ug
YXBwbHkgdGhpcyBvbmU8YnI+DQpvdGhlcndpc2UgdGhlIGNsb2NrcyB3aWxsIGJlIHdyb25nIGFn
YWluLjxicj4NCjxicj4NCkFsZXg8YnI+DQo8YnI+DQomZ3Q7IC0tLTxicj4NCiZndDvCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS88d2JyPmh3bWdyL3NtdTEwX2h3bWdyLmPCoCB8wqAg
NCArKy0tPGJyPg0KJmd0O8KgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5Lzx3YnI+aHdt
Z3IvdmVnYTEwX2h3bWdyLmMgfCAxMCArKysrKy0tLS0tPGJyPg0KJmd0O8KgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5Lzx3YnI+aHdtZ3IvdmVnYTEyX2h3bWdyLmMgfCAxMCArKysrKy0t
LS0tPGJyPg0KJmd0O8KgIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pPGJyPg0KJmd0Ozxicj4NCiZndDsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvPHdicj5wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvPHdicj5wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYzxicj4NCiZndDsgaW5kZXgg
ZDRiYzgzZTgxMzg5Li5jOTA1ZGY0MmFkYzUgMTAwNjQ0PGJyPg0KJmd0OyAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kLzx3YnI+cG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmM8YnI+DQomZ3Q7
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvPHdicj5wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdt
Z3IuYzxicj4NCiZndDsgQEAgLTk5Myw3ICs5OTMsNyBAQCBzdGF0aWMgaW50IHNtdTEwX2dldF9j
bG9ja19ieV90eXBlX3dpdGhfPHdicj5sYXRlbmN5KHN0cnVjdCBwcF9od21nciAqaHdtZ3IsPGJy
Pg0KJmd0Ozxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7bnVtX2xldmVscyA9
IDA7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSAmbHQ7IHBjbGtfdm9s
X3RhYmxlLSZndDtjb3VudDsgaSsrKSB7PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjbG9ja3MtJmd0O2RhdGFbaV0uY2xvY2tzX2luX2toeiA9IHBjbGtfdm9sX3RhYmxl
LSZndDtlbnRyaWVzW2ldLjx3YnI+Y2xrOzxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLmNsb2Nrc19pbl9raHogPSBwY2xrX3ZvbF90YWJs
ZS0mZ3Q7ZW50cmllc1tpXS5jbGsgKiAxMDs8YnI+DQomZ3Q7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLmxhdGVuY3lfaW5fdXMgPSBsYXRlbmN5X3Jl
cXVpcmVkID88YnI+DQomZ3Q7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc211MTBfZ2V0X21lbV9sYXRlbmN5KGh3bWdyLDxicj4NCiZndDvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2xrX3ZvbF90YWJsZS0mZ3Q7ZW50cmll
c1tpXS48d2JyPmNsaykgOjxicj4NCiZndDsgQEAgLTEwNDQsNyArMTA0NCw3IEBAIHN0YXRpYyBp
bnQgc211MTBfZ2V0X2Nsb2NrX2J5X3R5cGVfd2l0aF88d2JyPnZvbHRhZ2Uoc3RydWN0IHBwX2h3
bWdyICpod21nciw8YnI+DQomZ3Q7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZn
dDtudW1fbGV2ZWxzID0gMDs8YnI+DQomZ3Q7wqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBp
ICZsdDsgcGNsa192b2xfdGFibGUtJmd0O2NvdW50OyBpKyspIHs8YnI+DQomZ3Q7IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7ZGF0YVtpXS5jbG9ja3NfaW5fa2h6ID0g
cGNsa192b2xfdGFibGUtJmd0O2VudHJpZXNbaV0uPHdicj5jbGs7PGJyPg0KJmd0OyArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MtJmd0O2RhdGFbaV0uY2xvY2tzX2luX2toeiA9
IHBjbGtfdm9sX3RhYmxlLSZndDtlbnRyaWVzW2ldLjx3YnI+Y2xrwqAgKiAxMDs8YnI+DQomZ3Q7
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLnZvbHRh
Z2VfaW5fbXYgPSBwY2xrX3ZvbF90YWJsZS0mZ3Q7ZW50cmllc1tpXS48d2JyPnZvbDs8YnI+DQom
Z3Q7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtudW1fbGV2ZWxz
Kys7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqAgfTxicj4NCiZndDsgZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvPHdicj5wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kLzx3YnI+cG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jPGJy
Pg0KJmd0OyBpbmRleCAzYjhkMzZkZjUyZTkuLmU5YThiNTI3ZDQ4MSAxMDA2NDQ8YnI+DQomZ3Q7
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvPHdicj5wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3
bWdyLmM8YnI+DQomZ3Q7ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvPHdicj5wb3dlcnBsYXkv
aHdtZ3IvdmVnYTEwX2h3bWdyLmM8YnI+DQomZ3Q7IEBAIC00MDY3LDcgKzQwNjcsNyBAQCBzdGF0
aWMgdm9pZCB2ZWdhMTBfZ2V0X3NjbGtzKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsPGJyPg0KJmd0
O8KgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSAmbHQ7IGRlcF90YWJsZS0mZ3Q7Y291bnQ7
IGkrKykgezxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZGVw
X3RhYmxlLSZndDtlbnRyaWVzW2ldLmNsaykgezxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2Nsb2Nrcy0mZ3Q7
bnVtXzx3YnI+bGV2ZWxzXS5jbG9ja3NfaW5fa2h6ID08YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqDC
oMKgwqDCoMKgwqAgZGVwX3RhYmxlLSZndDtlbnRyaWVzW2ldLmNsazs8YnI+DQomZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdi
cj7CoMKgwqDCoMKgwqDCoMKgwqAgZGVwX3RhYmxlLSZndDtlbnRyaWVzW2ldLmNsayAqIDEwOzxi
cj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y2xvY2tzLSZndDtudW1fbGV2ZWxzKys7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH08YnI+DQomZ3Q7wqDCoMKgwqDCoMKgwqDCoCB9PGJyPg0KJmd0OyBAQCAtNDEw
NCw3ICs0MTA0LDcgQEAgc3RhdGljIHZvaWQgdmVnYTEwX2dldF9tZW1jbG9ja3Moc3RydWN0IHBw
X2h3bWdyICpod21nciw8YnI+DQomZ3Q7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7ZGF0YVtjbG9ja3MtJmd0O251bV88d2JyPmxldmVs
c10uY2xvY2tzX2luX2toeiA9PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhLSZndDttY2xrX2xhdGVuY3lfdGFibGUuPHdicj5lbnRy
aWVzPGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBbZGF0YS0mZ3Q7bWNsa19sYXRlbmN5X3RhYmxlLjx3YnI+Y291bnRdLmZyZXF1ZW5jeSA9
PGJyPg0KJmd0OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgwqDCoMKgwqDCoMKgIGRlcF90YWJsZS0mZ3Q7ZW50cmll
c1tpXS5jbGs7PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgwqDCoMKgwqDCoMKgIGRlcF90YWJsZS0m
Z3Q7ZW50cmllc1tpXS5jbGsgKiAxMDs8YnI+DQomZ3Q7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7ZGF0YVtjbG9ja3MtJmd0O251bV88
d2JyPmxldmVsc10ubGF0ZW5jeV9pbl91cyA9PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhLSZndDttY2xrX2xhdGVuY3lfdGFibGUu
PHdicj5lbnRyaWVzPGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBbZGF0YS0mZ3Q7bWNsa19sYXRlbmN5X3RhYmxlLjx3YnI+Y291bnRdLmxh
dGVuY3kgPTxicj4NCiZndDsgQEAgLTQxMjYsNyArNDEyNiw3IEBAIHN0YXRpYyB2b2lkIHZlZ2Ex
MF9nZXRfZGNlZmNsb2NrcyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLDxicj4NCiZndDvCoMKgwqDC
oMKgwqDCoMKgIHVpbnQzMl90IGk7PGJyPg0KJmd0Ozxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKg
IGZvciAoaSA9IDA7IGkgJmx0OyBkZXBfdGFibGUtJmd0O2NvdW50OyBpKyspIHs8YnI+DQomZ3Q7
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7ZGF0YVtpXS5jbG9ja3Nf
aW5fa2h6ID0gZGVwX3RhYmxlLSZndDtlbnRyaWVzW2ldLmNsazs8YnI+DQomZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7ZGF0YVtpXS5jbG9ja3NfaW5fa2h6ID0g
ZGVwX3RhYmxlLSZndDtlbnRyaWVzW2ldLmNsayAqIDEwOzxicj4NCiZndDvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MtJmd0O2RhdGFbaV0ubGF0ZW5jeV9pbl91cyA9IDA7
PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7bnVt
X2xldmVscysrOzxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgIH08YnI+DQomZ3Q7IEBAIC00MTQy
LDcgKzQxNDIsNyBAQCBzdGF0aWMgdm9pZCB2ZWdhMTBfZ2V0X3NvY2Nsb2NrcyhzdHJ1Y3QgcHBf
aHdtZ3IgKmh3bWdyLDxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGk7PGJyPg0K
Jmd0Ozxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgJmx0OyBkZXBfdGFi
bGUtJmd0O2NvdW50OyBpKyspIHs8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNsb2Nrcy0mZ3Q7ZGF0YVtpXS5jbG9ja3NfaW5fa2h6ID0gZGVwX3RhYmxlLSZndDtlbnRy
aWVzW2ldLmNsazs8YnI+DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2Nr
cy0mZ3Q7ZGF0YVtpXS5jbG9ja3NfaW5fa2h6ID0gZGVwX3RhYmxlLSZndDtlbnRyaWVzW2ldLmNs
ayAqIDEwOzxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3Mt
Jmd0O2RhdGFbaV0ubGF0ZW5jeV9pbl91cyA9IDA7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7bnVtX2xldmVscysrOzxicj4NCiZndDvCoMKgwqDC
oMKgwqDCoMKgIH08YnI+DQomZ3Q7IEBAIC00MjAyLDcgKzQyMDIsNyBAQCBzdGF0aWMgaW50IHZl
Z2ExMF9nZXRfY2xvY2tfYnlfdHlwZV93aXRoXzx3YnI+dm9sdGFnZShzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyLDxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgIH08YnI+DQomZ3Q7PGJyPg0KJmd0O8Kg
wqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSAmbHQ7IGRlcF90YWJsZS0mZ3Q7Y291bnQ7IGkr
Kykgezxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtk
YXRhW2ldLmNsb2Nrc19pbl9raHogPSBkZXBfdGFibGUtJmd0O2VudHJpZXNbaV0uY2xrOzxicj4N
CiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLmNs
b2Nrc19pbl9raHogPSBkZXBfdGFibGUtJmd0O2VudHJpZXNbaV0uY2xrwqAgKiAxMDs8YnI+DQom
Z3Q7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLnZv
bHRhZ2VfaW5fbXYgPSAodWludDMyX3QpKHRhYmxlX2luZm8tJmd0O3ZkZGNfPHdicj5sb29rdXBf
dGFibGUtJmd0Ozxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqAgZW50cmllc1tkZXBfdGFibGUtJmd0O2Vu
dHJpZXNbaV0uPHdicj52ZGRJbmRdLnVzX3ZkZCk7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNsb2Nrcy0mZ3Q7bnVtX2xldmVscysrOzxicj4NCiZndDsgZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvPHdicj5wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3
bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kLzx3YnI+cG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9o
d21nci5jPGJyPg0KJmd0OyBpbmRleCA3ODJlMjA5ODgyNGQuLmQ2ODVjZTdmODhjYyAxMDA2NDQ8
YnI+DQomZ3Q7IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvPHdicj5wb3dlcnBsYXkvaHdtZ3Iv
dmVnYTEyX2h3bWdyLmM8YnI+DQomZ3Q7ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvPHdicj5w
b3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmM8YnI+DQomZ3Q7IEBAIC0xNTc2LDcgKzE1NzYs
NyBAQCBzdGF0aWMgaW50IHZlZ2ExMl9nZXRfc2Nsa3Moc3RydWN0IHBwX2h3bWdyICpod21nciw8
YnI+DQomZ3Q7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSAmbHQ7IHVj
b3VudDsgaSsrKSB7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNs
b2Nrcy0mZ3Q7ZGF0YVtpXS5jbG9ja3NfaW5fa2h6ID08YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcG1fdGFibGUtJmd0O2RwbV9sZXZlbHNb
aV0udmFsdWUgKiAxMDA7PGJyPg0KJmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZHBtX3RhYmxlLSZndDtkcG1fbGV2ZWxzW2ldLnZhbHVlICogMTAwMDs8
YnI+DQomZ3Q7PGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2Nr
cy0mZ3Q7ZGF0YVtpXS5sYXRlbmN5X2luX3VzID0gMDs8YnI+DQomZ3Q7wqDCoMKgwqDCoMKgwqDC
oCB9PGJyPg0KJmd0OyBAQCAtMTYwOCw3ICsxNjA4LDcgQEAgc3RhdGljIGludCB2ZWdhMTJfZ2V0
X21lbWNsb2NrcyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLDxicj4NCiZndDs8YnI+DQomZ3Q7wqDC
oMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpICZsdDsgdWNvdW50OyBpKyspIHs8YnI+DQomZ3Q7
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLmNsb2Nr
c19pbl9raHogPTxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRwbV90YWJsZS0mZ3Q7ZHBtX2xldmVsc1tpXS52YWx1ZSAqIDEwMDs8YnI+DQom
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcG1fdGFi
bGUtJmd0O2RwbV9sZXZlbHNbaV0udmFsdWUgKiAxMDAwOzxicj4NCiZndDs8YnI+DQomZ3Q7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLmxhdGVuY3lf
aW5fdXMgPTxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGF0YS0mZ3Q7bWNsa19sYXRlbmN5X3RhYmxlLjx3YnI+ZW50cmllc1tpXS5sYXRl
bmN5ID08YnI+DQomZ3Q7IEBAIC0xNjM4LDcgKzE2MzgsNyBAQCBzdGF0aWMgaW50IHZlZ2ExMl9n
ZXRfZGNlZmNsb2NrcyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLDxicj4NCiZndDs8YnI+DQomZ3Q7
wqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpICZsdDsgdWNvdW50OyBpKyspIHs8YnI+DQom
Z3Q7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLmNs
b2Nrc19pbl9raHogPTxicj4NCiZndDsgLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRwbV90YWJsZS0mZ3Q7ZHBtX2xldmVsc1tpXS52YWx1ZSAqIDEwMDs8YnI+
DQomZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcG1f
dGFibGUtJmd0O2RwbV9sZXZlbHNbaV0udmFsdWUgKiAxMDAwOzxicj4NCiZndDs8YnI+DQomZ3Q7
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzLSZndDtkYXRhW2ldLmxhdGVu
Y3lfaW5fdXMgPSAwOzxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgIH08YnI+DQomZ3Q7IEBAIC0x
NjY2LDcgKzE2NjYsNyBAQCBzdGF0aWMgaW50IHZlZ2ExMl9nZXRfc29jY2xvY2tzKHN0cnVjdCBw
cF9od21nciAqaHdtZ3IsPGJyPg0KJmd0Ozxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgIGZvciAo
aSA9IDA7IGkgJmx0OyB1Y291bnQ7IGkrKykgezxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjbG9ja3MtJmd0O2RhdGFbaV0uY2xvY2tzX2luX2toeiA9PGJyPg0KJmd0
OyAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHBtX3RhYmxl
LSZndDtkcG1fbGV2ZWxzW2ldLnZhbHVlICogMTAwOzxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRwbV90YWJsZS0mZ3Q7ZHBtX2xldmVsc1tp
XS52YWx1ZSAqIDEwMDA7PGJyPg0KJmd0Ozxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjbG9ja3MtJmd0O2RhdGFbaV0ubGF0ZW5jeV9pbl91cyA9IDA7PGJyPg0KJmd0
O8KgwqDCoMKgwqDCoMKgwqAgfTxicj4NCiZndDsgQEAgLTE4MzgsNyArMTgzOCw3IEBAIHN0YXRp
YyBpbnQgdmVnYTEyX3ByaW50X2Nsb2NrX2xldmVscyg8d2JyPnN0cnVjdCBwcF9od21nciAqaHdt
Z3IsPGJyPg0KJmd0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqA8d2JyPsKgwqDCoCByZXR1cm4gLTEpOzxicj4NCiZndDvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpICZsdDsgY2xvY2tzLm51bV9sZXZl
bHM7IGkrKyk8YnI+DQomZ3Q7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNpemUgKz0gc3ByaW50ZihidWYgKyBzaXplLCAmcXVvdDslZDogJXVNaHogJXNc
biZxdW90Oyw8YnI+DQomZ3Q7IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoCBpLCBjbG9ja3MuZGF0YVtpXS5jbG9ja3NfaW5f
a2h6IC8gMTAwLDxicj4NCiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2JyPsKgIGksIGNsb2Nrcy5kYXRhW2ldLmNsb2Nrc19p
bl9raHogLyAxMDAwLDxicj4NCiZndDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqAgKGNsb2Nrcy5kYXRhW2ldLmNsb2Nr
c19pbl9raHogPT0gbm93KSA/ICZxdW90OyomcXVvdDsgOiAmcXVvdDsmcXVvdDspOzxicj4NCiZn
dDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazs8YnI+DQomZ3Q7PGJyPg0K
Jmd0OyAtLTxicj4NCiZndDsgMi4xNy4xPGJyPg0KJmd0Ozxicj4NCiZndDsgX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fPHdicj5fX19fX19fX19fX19fX19fXzxicj4NCiZndDsgYW1kLWdm
eCBtYWlsaW5nIGxpc3Q8YnI+DQomZ3Q7IDxhIGhyZWY9Im1haWx0bzphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPC9hPjxicj4NCiZndDsgPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4IiBpZD0ibV8tMTc1MDIzODY4NzIwMDEzNDA3MExQbG5r
OTI3MjI4IiBjbGFzcz0ibV8tMTc1MDIzODY4NzIwMDEzNDA3ME9XQUF1dG9MaW5rIiB0YXJnZXQ9
Il9ibGFuayI+DQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy88d2JyPm1haWxtYW4vbGlz
dGluZm8vYW1kLWdmeDwvYT4NCjwvZGl2PjwvZGl2PjxkaXYgaWQ9Im1fLTE3NTAyMzg2ODcyMDAx
MzQwNzBMUEJvcmRlcl9HVF8xNTI5NTA1Nzg5MzgyMC41MjA4OTA3MzQ4MDA4NTYiIHN0eWxlPSJt
YXJnaW4tYm90dG9tOjIwcHg7b3ZlcmZsb3c6YXV0bzt3aWR0aDoxMDAlO3RleHQtaW5kZW50OjBw
eCI+DQo8dGFibGUgaWQ9Im1fLTE3NTAyMzg2ODcyMDAxMzQwNzBMUENvbnRhaW5lcl8xNTI5NTA1
Nzg5Mzc5MC4wNjc3MjE3NjkwNzU0NDYzNiIgc3R5bGU9IndpZHRoOjkwJTtiYWNrZ3JvdW5kLWNv
bG9yOnJnYigyNTUsMjU1LDI1NSk7b3ZlcmZsb3c6YXV0bztwYWRkaW5nLXRvcDoyMHB4O3BhZGRp
bmctYm90dG9tOjIwcHg7bWFyZ2luLXRvcDoyMHB4O2JvcmRlci10b3A6MXB4IGRvdHRlZCByZ2Io
MjAwLDIwMCwyMDApO2JvcmRlci1ib3R0b206MXB4IGRvdHRlZCByZ2IoMjAwLDIwMCwyMDApIiBj
ZWxsc3BhY2luZz0iMCI+DQo8dGJvZHk+DQo8dHIgc3R5bGU9ImJvcmRlci1zcGFjaW5nOjBweCIg
dmFsaWduPSJ0b3AiPg0KPHRkIGlkPSJtXy0xNzUwMjM4Njg3MjAwMTM0MDcwVGV4dENlbGxfMTUy
OTUwNTc4OTM4MDAuNjkzOTE0NzIzMzQ4OTIyIiBjb2xzcGFuPSIyIiBzdHlsZT0idmVydGljYWwt
YWxpZ246dG9wO3BhZGRpbmc6MHB4O2Rpc3BsYXk6dGFibGUtY2VsbCI+DQo8ZGl2IGlkPSJtXy0x
NzUwMjM4Njg3MjAwMTM0MDcwTFBSZW1vdmVQcmV2aWV3Q29udGFpbmVyXzE1Mjk1MDU3ODkzODAw
LjUwMzEzNTIyMTQwNDE5NCI+PC9kaXY+DQo8ZGl2IGlkPSJtXy0xNzUwMjM4Njg3MjAwMTM0MDcw
TFBUaXRsZV8xNTI5NTA1Nzg5MzgwMC42MTk1MTE0Nzk5OTY3MjMyIiBzdHlsZT0iY29sb3I6cmdi
KDAsMTIwLDIxNSk7Zm9udC13ZWlnaHQ6bm9ybWFsO2ZvbnQtc2l6ZToyMXB4O2ZvbnQtZmFtaWx5
OndmX3NlZ29lLXVpX2xpZ2h0LCZxdW90O1NlZ29lIFVJIExpZ2h0JnF1b3Q7LCZxdW90O1NlZ29l
IFdQIExpZ2h0JnF1b3Q7LCZxdW90O1NlZ29lIFVJJnF1b3Q7LCZxdW90O1NlZ29lIFdQJnF1b3Q7
LFRhaG9tYSxBcmlhbCxzYW5zLXNlcmlmO2xpbmUtaGVpZ2h0OjIxcHgiPg0KPGEgaWQ9Im1fLTE3
NTAyMzg2ODcyMDAxMzQwNzBMUFVybEFuY2hvcl8xNTI5NTA1Nzg5MzgxMC4wMTYzMzQ5MDI5NzAw
OTY5ODciIGhyZWY9Imh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeCIgc3R5bGU9InRleHQtZGVjb3JhdGlvbjpub25lIiB0YXJnZXQ9Il9ibGFuayI+
YW1kLWdmeCBJbmZvIFBhZ2UgLSBmcmVlZGVza3RvcC5vcmc8L2E+PC9kaXY+DQo8ZGl2IGlkPSJt
Xy0xNzUwMjM4Njg3MjAwMTM0MDcwTFBNZXRhZGF0YV8xNTI5NTA1Nzg5MzgxMC44MzYwNTQzNzYy
MzM4MjA2IiBzdHlsZT0ibWFyZ2luOjEwcHggMHB4IDE2cHg7Y29sb3I6cmdiKDEwMiwxMDIsMTAy
KTtmb250LXdlaWdodDpub3JtYWw7Zm9udC1mYW1pbHk6d2Zfc2Vnb2UtdWlfbm9ybWFsLCZxdW90
O1NlZ29lIFVJJnF1b3Q7LCZxdW90O1NlZ29lIFdQJnF1b3Q7LFRhaG9tYSxBcmlhbCxzYW5zLXNl
cmlmO2ZvbnQtc2l6ZToxNHB4O2xpbmUtaGVpZ2h0OjE0cHgiPg0KPGEgaHJlZj0iaHR0cDovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzwvYT48L2Rpdj4NCjxkaXYgaWQ9Im1fLTE3NTAyMzg2ODcyMDAxMzQwNzBMUERlc2NyaXB0aW9u
XzE1Mjk1MDU3ODkzODIwLjE2NTU0NDkwODcwNjgxNzciIHN0eWxlPSJkaXNwbGF5OmJsb2NrO2Nv
bG9yOnJnYigxMDIsMTAyLDEwMik7Zm9udC13ZWlnaHQ6bm9ybWFsO2ZvbnQtZmFtaWx5OndmX3Nl
Z29lLXVpX25vcm1hbCwmcXVvdDtTZWdvZSBVSSZxdW90OywmcXVvdDtTZWdvZSBXUCZxdW90OyxU
YWhvbWEsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTRweDtsaW5lLWhlaWdodDoyMHB4O21h
eC1oZWlnaHQ6MTAwcHg7b3ZlcmZsb3c6aGlkZGVuIj4NClN1YnNjcmliaW5nIHRvIGFtZC1nZng6
IFN1YnNjcmliZSB0byBhbWQtZ2Z4IGJ5IGZpbGxpbmcgb3V0IHRoZSBmb2xsb3dpbmcgZm9ybS4g
VXNlIG9mIGFsbCA8YSBocmVmPSJodHRwOi8vZnJlZWRlc2t0b3Aub3JnIiB0YXJnZXQ9Il9ibGFu
ayI+ZnJlZWRlc2t0b3Aub3JnPC9hPiBsaXN0cyBpcyBzdWJqZWN0IHRvIG91ciBDb2RlIG9mIENv
bmR1Y3QuPC9kaXY+DQo8L3RkPg0KPC90cj4NCjwvdGJvZHk+DQo8L3RhYmxlPg0KPC9kaXY+DQo8
YnI+DQo8YnI+DQo8L2Rpdj4NCjwvc3Bhbj48L2ZvbnQ+PC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0K
PC9kaXY+DQoNCjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+DQo=
--000000000000c4e8d2056f1454d1--

--===============1353780719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1353780719==--
